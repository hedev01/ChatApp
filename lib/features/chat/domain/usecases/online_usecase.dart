import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class OnlineUsecase {
  final ChatRepository chatRepository;
  OnlineUsecase(this.chatRepository);
  Stream<Set<String>> call(){
    return chatRepository.online();
  }
}