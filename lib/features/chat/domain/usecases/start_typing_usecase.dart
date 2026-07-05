import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class StartTypingUsecase {
  final ChatRepository chatRepository;
  StartTypingUsecase(this.chatRepository);
  Future<void> call(String receiverId){
    return chatRepository.startTyping(receiverId);
  }
}