class GetUserEntity {
  bool? isSuccess;
  List<GetUserDataEntity>? data;
  String? errorMessage;
  GetUserEntity({this.isSuccess, this.data, this.errorMessage});
}

class GetUserDataEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  GetUserDataEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl
  });
}
