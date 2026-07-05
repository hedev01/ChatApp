import 'package:chat_app/features/chat/domain/entities/send_message_request_entity.dart';

class SendMessageRequestModel extends SendMessageRequestEntity {
  SendMessageRequestModel({
    required super.senderId,
    required super.receiverId,
    required super.content,
  });
  Map<String, dynamic> toJson() {
    return {"senderId": senderId, "receiverId": receiverId, "content": content};
  }
}
