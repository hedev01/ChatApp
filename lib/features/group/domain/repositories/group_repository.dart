
abstract class GroupRepository {
  Future<void> connect(String userId);
  Future<void> createGroup(String groupName, String avatarUrl, List<String> members , String createdByName);
  Future<void> deleteGroup(String groupId, String groupName);
  Stream<String> get groupCreated;
  Stream<String> get groupDeleted;
}
