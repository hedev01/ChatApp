import 'package:chat_app/features/Auth/domain/entities/register_request_entity.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_event.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_state.dart';
import 'package:chat_app/features/user/domain/usecase/save_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthUseCase authUseCase;
  final SaveUserUsecase saveUserUsecase;
  RegisterBloc(this.authUseCase , this.saveUserUsecase) : super(RegisterState()) {
    on<RegisterSubmitted>(_onRegister);
  }
  Future<void> _onRegister(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      final user = await authUseCase.register(
        RegisterRequestEntity(
          username: event.username,
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
        ),
      );
      if (user!.errorMessage != null && user.errorMessage!.isNotEmpty) {
        emit(
          state.copyWith(
            status: RegisterStatus.failure,
            error: user.errorMessage,
          ),
        );
      } else {
        await saveUserUsecase(user.data!);
        emit(state.copyWith(status: RegisterStatus.success, user: user));
      }
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure, error: e.toString()));
    }
  }
}
