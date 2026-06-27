import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';

abstract class ChatRepository {
  Future<GetUserEntity> getUsers(String userId);
}
