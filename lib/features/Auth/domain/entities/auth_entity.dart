class AuthEntity {
  bool? isSuccess;
  AuthDataEntity? data;
  String? errorMessage;
  AuthEntity({this.isSuccess, this.data, this.errorMessage});
}

class AuthDataEntity {
  final int id;
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String accessToken;
  final String avatarUrl;
  AuthDataEntity({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accessToken,
    required this.avatarUrl
  });
}
