import '../../../domain/entities/user_entity.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState {
  final RegisterStatus status;
  final UserEntity? user;
  final String? error;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.user,
    this.error,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    UserEntity? user,
    String? error,
  }) {
    return RegisterState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }
}
