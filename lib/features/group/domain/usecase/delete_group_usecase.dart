import 'package:chat_app/features/group/domain/repositories/group_repository.dart';

class DeleteGroupUsecase {
  final GroupRepository repository;
  DeleteGroupUsecase(this.repository);

  Future<void> call(String groupId, String groupName) {
    return repository.deleteGroup(groupId, groupName);
  }
}
