import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class UserStopTypingUsecase {
  final ChatRepository chatRepository;
  UserStopTypingUsecase(this.chatRepository);
  Stream<String> call(){
    return chatRepository.userStopTyping();
  }
}