class UserEntity {
  bool? isSuccess;
  UserDataEntity? data;
  String? errorMessage;
  UserEntity({this.isSuccess, this.data, this.errorMessage});
}

class UserDataEntity {
  final int id;
  final String userId;
  final String chatType;
  final String title;
  final String groupId;
  final String email;
  final String accessToken;
  final String avatarUrl;
  UserDataEntity({
    required this.id,
    required this.userId,
    required this.chatType,
    required this.groupId,
    required this.title,
    required this.email,
    required this.accessToken,
    required this.avatarUrl
  });
}
