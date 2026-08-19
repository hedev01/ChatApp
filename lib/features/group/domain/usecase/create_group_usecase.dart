import 'package:chat_app/features/group/domain/repositories/group_repository.dart';

class CreateGroupUsecase {
  final GroupRepository _repository;
  CreateGroupUsecase(this._repository);

  Future<void> call(
    String groupName,
    String avatarUrl,
    List<String> members,
    String createdByName,
  ) async {
    return _repository.createGroup(groupName, avatarUrl, members , createdByName);
  }
}
