class UserEntity {
  bool? isSuccess;
  UserDataEntity? data;
  String? errorMessage;
  UserEntity({this.isSuccess, this.data, this.errorMessage});
}

class UserDataEntity {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String accessToken;
  final String avatarUrl;
  UserDataEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accessToken,
    required this.avatarUrl
  });
}
