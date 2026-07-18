import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/mark_as_read_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/offline_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/online_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/online_users_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/read_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/receive_messages_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/start_typing_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/stop_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/stop_typing_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/user_is_typing_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/user_stop_typing_usecase.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/helper.dart';

class ChatCubit extends Cubit<ChatState> {
  final ConnectChatUseCase connectChat;
  final SendMessageUsecase sendMessage;
  final ReceiveMessagesUseCase receiveMessages;
  final StopChatUsecase stopChatUsecase;
  final OnlineUsecase onlineUsecase;
  final OfflineUsecase offlineUsecase;
  final OnlineUsersUsecase onlineUsersUsecase;
  final MarkAsReadUsecase markAsReadUsecase;
  final ReadUsecase readUsecase;
  final UserIsTypingUsecase userIsTypingUsecase;
  final UserStopTypingUsecase userStopTypingUsecase;
  final StartTypingUsecase startTypingUsecase;
  final StopTypingUsecase stopTypingUsecase;

  ChatCubit(
    this.connectChat,
    this.sendMessage,
    this.receiveMessages,
    this.stopChatUsecase,
    this.onlineUsecase,
    this.offlineUsecase,
    this.onlineUsersUsecase,
    this.markAsReadUsecase,
    this.userIsTypingUsecase,
    this.userStopTypingUsecase,
    this.startTypingUsecase,
    this.stopTypingUsecase,
    this.readUsecase,
  ) : super(const ChatState());

  Future<void> connect(String userId) async {
    await connectChat(userId);

    receiveMessages().listen((message) {
      final senderId = message.senderId;
      final receiverId = message.receiverId;

      final conversationId = Helper.getConversationId(senderId, receiverId);
      final updatedMessages = Map<String, List<MessageEntity>>.from(
        state.messages,
      );

      final list = List<MessageEntity>.from(
        updatedMessages[conversationId] ?? [],
      );
      list.add(message);

      updatedMessages[conversationId] = list;

      final updatedUnread = Map<String, int>.from(state.unreadCount);
      updatedUnread[senderId] = (updatedUnread[senderId] ?? 0) + 1;

      final updatedLast = Map<String, MessageEntity>.from(state.lastMessages);
      updatedLast[senderId] = message;

      emit(
        state.copyWith(
          messages: updatedMessages,
          unreadCount: updatedUnread,
          lastMessages: updatedLast,
        ),
      );
    });

    onlineUsersUsecase().listen((users) {
      final map = {for (final id in users) id: true};

      emit(state.copyWith(isOnline: map));
    });

    onlineUsecase().listen((onlineUsers) {
      emit(
        state.copyWith(
          isOnline: {for (final userId in onlineUsers) userId: true},
        ),
      );
    });

    offlineUsecase().listen((offlineUsers) {
      emit(
        state.copyWith(
          isOnline: {for (final userId in offlineUsers) userId: false},
        ),
      );
    });
    userIsTypingUsecase().listen((senderId) {
      final map = Map<String, bool>.from(state.isTyping);

      map[senderId] = true;

      emit(state.copyWith(isTyping: map));
    });

    userStopTypingUsecase().listen((senderId) {
      final map = Map<String, bool>.from(state.isTyping);

      map[senderId] = false;

      emit(state.copyWith(isTyping: map));
    });

    readUsecase().listen((args) {
      final receiverId = args[0]!.toString();
      final senderId = args[1]!.toString();

      final conversationId = Helper.getConversationId(receiverId, senderId);

      final updatedMessages = Map<String, List<MessageEntity>>.from(
        state.messages,
      );

      final conversation = updatedMessages[conversationId];

      if (conversation == null) return;

      updatedMessages[conversationId] = conversation.map((message) {
        print(message.senderId);
        if (message.senderId == senderId && !message.isRead) {
          return message.copyWith(isRead: true);
        }
        return message;
      }).toList();

      emit(state.copyWith(messages: updatedMessages));
    });
  }

 Future<void> send(MessageEntity message) async {
  await sendMessage(message);

  final conversationId = Helper.getConversationId(
    message.senderId,
    message.receiverId,
  );

  final updatedMessages = Map<String, List<MessageEntity>>.from(state.messages);

  final list = List<MessageEntity>.from(
    updatedMessages[conversationId] ?? [],
  );

  list.add(message);

  updatedMessages[conversationId] = list;

  final updatedLast = Map<String, MessageEntity>.from(state.lastMessages);
  updatedLast[message.receiverId] = message;

  emit(
    state.copyWith(
      messages: updatedMessages,
      lastMessages: updatedLast,
    ),
  );
}

  Future<void> markAsRead(String senderId, String receiverId) async {
    await markAsReadUsecase(senderId);

    final conversationId = Helper.getConversationId(senderId, receiverId);

    final updatedMessages = Map<String, List<MessageEntity>>.from(
      state.messages,
    );

    final list = updatedMessages[conversationId];

    if (list != null) {
      updatedMessages[conversationId] = list
          .map((m) => m.copyWith(isRead: true))
          .toList();
    }

    final updatedUnread = Map<String, int>.from(state.unreadCount);
    updatedUnread[senderId] = 0;

    emit(state.copyWith(messages: updatedMessages, unreadCount: updatedUnread));
  }

  Future<void> startTyping(String receiverId) async {
    await startTypingUsecase(receiverId);
  }

  Future<void> stopTyping(String receiverId) async {
    await stopTypingUsecase(receiverId);
  }

  Future<void> stop() async {
    await stopChatUsecase();
  }
}
