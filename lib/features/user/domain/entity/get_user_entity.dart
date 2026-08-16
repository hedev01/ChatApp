class GetUserEntity {
  bool? isSuccess;
  List<GetUserDataEntity>? data;
  String? errorMessage;
  GetUserEntity({this.isSuccess, this.data, this.errorMessage});
}

class GetUserDataEntity {
  final int id;
  final String userId;
  final String chatType;
  final String title;
  final String groupId;
  final String email;
  final String avatarUrl;
  GetUserDataEntity({
    required this.id,
    required this.userId,
    required this.chatType,
    required this.title,
    required this.groupId,
    required this.email,
    required this.avatarUrl
  });
}
