import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/mark_as_read_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/offline_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/online_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/online_users_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/receive_messages_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/stop_chat_usecase.dart';
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

  ChatCubit(
    this.connectChat,
    this.sendMessage,
    this.receiveMessages,
    this.stopChatUsecase,
    this.onlineUsecase,
    this.offlineUsecase,
    this.onlineUsersUsecase,
    this.markAsReadUsecase,
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
  }

  Future<void> send(String text, String senderId, String receiverId) async {
    final message = MessageEntity(
      senderId: senderId,
      receiverId: receiverId,
      content: text,
      isRead: false,
    );

    await sendMessage(message);

    final conversationId = Helper.getConversationId(senderId, receiverId);

    final updatedMessages = Map<String, List<MessageEntity>>.from(
      state.messages,
    );

    final list = List<MessageEntity>.from(
      updatedMessages[conversationId] ?? [],
    );
    list.add(message);

    updatedMessages[conversationId] = list;

    final updatedLast = Map<String, MessageEntity>.from(state.lastMessages);
    updatedLast[receiverId] = message;

    emit(state.copyWith(messages: updatedMessages, lastMessages: updatedLast));
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

  Future<void> stop() async {
    await stopChatUsecase();
  }
}
