import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final AuthEntity? user;
  final String? error;
  LoginState({this.status = LoginStatus.initial, this.user, this.error});

  LoginState copyWith({LoginStatus? status, AuthEntity? user, String? error}) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
