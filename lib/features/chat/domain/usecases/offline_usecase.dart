import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class OfflineUsecase {
  final ChatRepository chatRepository;
  OfflineUsecase(this.chatRepository);
  Stream<Set<String>> call() {
    return chatRepository.offline();
  }
}
