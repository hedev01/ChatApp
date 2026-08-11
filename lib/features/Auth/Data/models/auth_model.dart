import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({required super.isSuccess, super.data, super.errorMessage});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      isSuccess: json["isSuccess"],
      errorMessage: json["errorMessage"],
      data: json["data"] != null ? AuthDataModel.fromJson(json["data"]) : null,
    );
  }
}

class AuthDataModel extends AuthDataEntity {
  AuthDataModel({
    required super.id,
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.accessToken,
    required super.avatarUrl,
  });

  factory AuthDataModel.fromEntity(AuthDataEntity entity) {
    return AuthDataModel(
      id: entity.id,
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      accessToken: entity.accessToken,
      avatarUrl: entity.avatarUrl,
    );
  }

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      id: json["id"],
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      accessToken: json["accessToken"],
      avatarUrl: json["avatarUrl"] ?? "",
    );
  }

  factory AuthDataModel.fromHive(Map<dynamic, dynamic> json) {
    return AuthDataModel(
      id: json["id"],
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      accessToken: json["accessToken"],
      avatarUrl: json["avatarUrl"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "accessToken": accessToken,
      "avatarUrl": avatarUrl,
    };
  }
}
