import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class UserIsTypingUsecase {
  final ChatRepository chatRepository;
  UserIsTypingUsecase(this.chatRepository);
  Stream<String> call(){
    return chatRepository.userIsTyping();
  }
}