import 'package:chat_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {

  MessageModel({
    required super.senderId,
    required super.receiverId,
    required super.content,
  });

  factory MessageModel.fromHub(List<Object?> args){

    return MessageModel(
      senderId: args[0].toString(),
      receiverId: "",
      content: args[1].toString(),
    );

  }

  Map<String,dynamic> toJson(){

    return {
      "senderId":senderId,
      "receiverId":receiverId,
      "content":content,
    };

  }

}