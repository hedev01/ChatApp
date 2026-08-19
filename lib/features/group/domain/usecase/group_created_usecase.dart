import 'package:chat_app/features/group/domain/repositories/group_repository.dart';

class GroupCreatedUsecase {
  final GroupRepository repository;
  GroupCreatedUsecase(this.repository);
  Stream<String> call() {
    return repository.groupCreated;
  }
}