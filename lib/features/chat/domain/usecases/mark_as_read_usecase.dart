import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class MarkAsReadUsecase {
  final ChatRepository chatRepository;
  MarkAsReadUsecase(this.chatRepository);
  Future<void> call(String senderId){
    return chatRepository.markAsRead(senderId);
  }
}