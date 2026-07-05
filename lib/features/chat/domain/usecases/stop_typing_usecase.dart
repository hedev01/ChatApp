import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class StopTypingUsecase {
  final ChatRepository chatRepository;
  StopTypingUsecase(this.chatRepository);

  Future<void> call(String receiverId) {
    return chatRepository.stopTyping(receiverId);
  }
}
