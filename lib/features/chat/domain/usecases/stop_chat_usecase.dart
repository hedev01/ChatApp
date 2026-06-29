import '../repositories/chat_repository.dart';

class StopChatUsecase {
  final ChatRepository repository;
  StopChatUsecase(this.repository);
  Future<void> call() {
    return repository.stop();
  }
}
