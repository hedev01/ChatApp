import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class OnlineUsersUsecase {
  final ChatRepository chatRepository;
  OnlineUsersUsecase(this.chatRepository);

  Stream<List<String>> call() {
    return chatRepository.onlineUsers();
  }
}
