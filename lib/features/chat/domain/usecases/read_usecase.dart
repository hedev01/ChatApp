import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ReadUsecase {
  final ChatRepository chatRepository;
  ReadUsecase(this.chatRepository);

  Stream<List<Object?>> call(){
    return chatRepository.read();
  }
}