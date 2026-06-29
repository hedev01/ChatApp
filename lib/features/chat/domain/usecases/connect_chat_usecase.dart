import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ConnectChatUseCase {
  final ChatRepository repository;

  ConnectChatUseCase(this.repository);

  Future<void> call(String userId) {
    return repository.connect(userId);
  }
}
