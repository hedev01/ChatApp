import 'package:chat_app/features/chat/domain/entities/message_reaction_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class GetReactionUsecase {
  final ChatRepository repository;
  GetReactionUsecase(this.repository);
  Stream<MessageReactionEntity> call() {
    return repository.getReaction();
  }
}
