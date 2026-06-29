import 'package:chat_app/features/chat/domain/entities/message_entity.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/receive_messages_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/stop_chat_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<List<MessageEntity>>{

  final ConnectChatUseCase connectChat;
  final SendMessageUsecase sendMessage;
  final ReceiveMessagesUseCase receiveMessages;
  final StopChatUsecase stopChatUsecase;

  ChatCubit(
      this.connectChat,
      this.sendMessage,
      this.receiveMessages,
      this.stopChatUsecase
      ) : super([]);

  Future<void> connect(String userId) async{

    await connectChat(userId);

    receiveMessages().listen((message){

      emit([
        ...state,
        message,
      ]);

    });

  }

  Future<void> send(String text , String senderId , String receiverId) async{

    final message = MessageEntity(
      senderId: senderId,
      receiverId: receiverId,
      content: text,
    );

    await sendMessage(message);

    emit([
      ...state,
      message,
    ]);

  }

  Future<void> stop() async{
    await stopChatUsecase();
  }

}