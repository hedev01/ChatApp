import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';

enum UserStatus { initial, loading, success, failure }

class AuthUserState {
  UserStatus userStatus;
  final AuthDataEntity? userDataEntity;
  final String? error;
  AuthUserState({
    this.userStatus = UserStatus.initial,
    this.userDataEntity,
    this.error,
  });

  AuthUserState copyWith({
    UserStatus? userStatus,
    AuthDataEntity? userDataEntity,
    String? error,
  }) {
    return AuthUserState(
      userStatus: userStatus ?? this.userStatus,
      userDataEntity: userDataEntity ?? this.userDataEntity,
      error: error ?? this.error,
    );
  }
}
