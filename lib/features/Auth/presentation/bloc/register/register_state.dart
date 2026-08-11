import 'package:chat_app/features/Auth/domain/entities/auth_entity.dart';


enum RegisterStatus { initial, loading, success, failure }

class RegisterState {
  final RegisterStatus status;
  final AuthEntity? user;
  final String? error;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.user,
    this.error,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    AuthEntity? user,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }
}
