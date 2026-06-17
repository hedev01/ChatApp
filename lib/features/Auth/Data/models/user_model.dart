import 'package:chat_app/features/Auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.isSuccess, super.data, super.errorMessage});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      isSuccess: json["isSuccess"],
      errorMessage: json["errorMessage"],
      data: json["data"] != null ? UserDataModel.fromJson(json["data"]) : null,
    );
  }
}

class UserDataModel extends UserDataEntity {
  UserDataModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.accessToken,
  });

  factory UserDataModel.fromEntity(UserDataEntity entity) {
    return UserDataModel(
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      accessToken: entity.accessToken,
    );
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      accessToken: json["accessToken"],
    );
  }

   factory UserDataModel.fromHive(Map<dynamic, dynamic> json) {
    return UserDataModel(
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      accessToken: json["accessToken"],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "accessToken": accessToken,
    };
    }
}
