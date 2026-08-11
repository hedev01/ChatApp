import 'package:chat_app/features/group/data/data_source/group_remote_data_source.dart';
import 'package:chat_app/features/group/domain/repositories/group_repository.dart';

class GroupRepositoryImp implements GroupRepository {
  final GroupRemoteDataSource remote;
  GroupRepositoryImp(this.remote);
  @override
  Future<void> connect(String userId) {
    return remote.connect(userId);
  }

  @override
  Future<void> createGroup(
    String groupName,
    String avatarUrl,
    List<String> members,
  ) {
    return remote.createGroup(groupName, avatarUrl, members);
  }
}
