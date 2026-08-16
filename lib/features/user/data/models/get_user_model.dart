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
    required super.id,
    required super.userId,
    required super.groupId,
    required super.chatType,
    required super.title,
    
    required super.email,
    required super.avatarUrl
  });

  factory GetUserDataModel.fromEntity(UserDataEntity entity) {
    return GetUserDataModel(
      id: entity.id,
      userId: entity.userId,
      chatType: entity.chatType,
      groupId: entity.groupId,
      title: entity.title,
      email: entity.email,
      avatarUrl: entity.avatarUrl
    );
  }

  factory GetUserDataModel.fromJson(Map<String, dynamic> json) {
    return GetUserDataModel(
      id: json["id"],
      userId: json["userId"],
      groupId: json["groupId"],
      chatType: json["chatType"],
      title: json["title"],
      email: json["email"] ?? "",
      avatarUrl: json["avatarUrl"] ?? ""
    );
  }

   factory GetUserDataModel.fromHive(Map<dynamic, dynamic> json) {
    return GetUserDataModel(
      id: json["id"],
      userId: json["userId"],
      chatType: json["chatType"],
      groupId: json["groupId"],
      title: json["title"],
      email: json["email"] ?? "",
      avatarUrl: json["avatarUrl"] ?? ""
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "chatType" : chatType,
      "groupId" : groupId,
      "title" : title,
      "email": email,
    };
    }
}
