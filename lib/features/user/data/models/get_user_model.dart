import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';

class GetUserModel extends GetUserEntity {
  GetUserModel({required super.isSuccess, super.data, super.errorMessage});

  factory GetUserModel.fromJson(Map<String, dynamic> json) {
    return GetUserModel(
      isSuccess: json["isSuccess"],
      errorMessage: json["errorMessage"],
      data: json["data"] != null
          ? (json["data"] as List)
              .map((e) => GetUserDataModel.fromJson(e))
              .toList()
          : [],
    );
  }
}

class GetUserDataModel extends GetUserDataEntity {
  GetUserDataModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.avatarUrl
  });

  factory GetUserDataModel.fromEntity(UserDataEntity entity) {
    return GetUserDataModel(
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      avatarUrl: entity.avatarUrl
    );
  }

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) {
    return GetUserDataModel(
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      avatarUrl: json["avatarUrl"] ?? ""
    );
  }

   factory GetUserDataModel.fromHive(Map<dynamic, dynamic> json) {
    return GetUserDataModel(
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      avatarUrl: json["avatarUrl"] ?? ""
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
    };
    }
}
