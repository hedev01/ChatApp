import 'package:chat_app/features/chat/domain/entities/message_reaction_request_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class SendReactionUsecase {
  final ChatRepository repository;
  SendReactionUsecase(this.repository);

  Future<void> call(MessageReactionRequestEntity entity) {
    return repository.sendReaction(entity);
  }
}
