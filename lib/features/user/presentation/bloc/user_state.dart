import 'package:chat_app/features/user/domain/entity/user_entity.dart';

enum UserStatus { initial, loading, success, failure }

class UserState {
  UserStatus userStatus;
  final UserDataEntity? userDataEntity;
  final String? error;
  UserState({
    this.userStatus = UserStatus.initial,
    this.userDataEntity,
    this.error,
  });

  UserState copyWith({
    UserStatus? userStatus,
    UserDataEntity? userDataEntity,
    String? error,
  }) {
    return UserState(
      userStatus: userStatus ?? this.userStatus,
      userDataEntity: userDataEntity ?? this.userDataEntity,
      error: error ?? this.error,
    );
  }
}
