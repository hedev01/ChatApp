import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';

class UserRequestModel extends RegisterRequestEntity {
  UserRequestModel({
    required super.username,
    required super.email,
    required super.password,
    required super.firstName,
    required super.lastName,
  });
  
  factory UserRequestModel.fromEntity(RegisterRequestEntity entity) {
    return UserRequestModel(
      username: entity.username,
      email: entity.email,
      password: entity.password,
      firstName: entity.firstName,
      lastName: entity.lastName,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "userName": username,
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
