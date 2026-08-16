import 'package:chat_app/features/user/domain/entity/user_entity.dart';

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
    required super.id,
    required super.userId,
    required super.chatType,
    required super.title,
    required super.groupId,
    required super.email,
    required super.accessToken,
    required super.avatarUrl,
  });

  factory UserDataModel.fromEntity(UserDataEntity entity) {
    return UserDataModel(
      id: entity.id,
      userId: entity.userId,
      chatType: entity.chatType,
      groupId: entity.groupId,
      title: entity.title,
      email: entity.email,
      accessToken: entity.accessToken,
      avatarUrl: entity.avatarUrl,
    );
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json["id"],
      userId: json["userId"],
      chatType: json["chatType"],
      title: json["title"],
      groupId: json["groupId"],
      email: json["email"] ?? "",
      accessToken: json["accessToken"],
      avatarUrl: json["avatarUrl"] ?? "",
    );
  }

  factory UserDataModel.fromHive(Map<dynamic, dynamic> json) {
    return UserDataModel(
      id: json["id"],
      userId: json["userId"],
      title: json["title"],
      chatType: json["chatType"],
      groupId: json["groupId"],
      email: json["email"] ?? "",
      accessToken: json["accessToken"],
      avatarUrl: json["avatarUrl"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "userId": userId,
      "chatType" : chatType,
      "title": title,
      "groupId": groupId,
      "email": email,
      "accessToken": accessToken,
      "avatarUrl": avatarUrl,
    };
  }
}
