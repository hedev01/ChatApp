import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ChatUsecase {
  final ChatRepository chatRepository;
  ChatUsecase(this.chatRepository);
  Future<GetUserEntity> getUsers(String userId) async {
    return await chatRepository.getUsers(userId);
  }
}
