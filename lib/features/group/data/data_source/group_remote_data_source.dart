abstract class GroupRemoteDataSource {
  Future<void> connect(String userId);
  Future<void> createGroup(String groupName, String avatarUrl, List<String> members);
}