import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_event.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_state.dart';
import 'package:chat_app/features/user/domain/usecase/save_user_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthUseCase useCase;
   final SaveUserUsecase saveUserUsecase;
  LoginBloc(this.useCase , this.saveUserUsecase) : super(LoginState()) {
    on<LoginSubmitted>(_onLogin);
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final user = await useCase.login(event.email, event.password);
      if (user.isSuccess!) {
        await saveUserUsecase(user.data!);
        emit(state.copyWith(user: user, status: LoginStatus.success));
      } else {
        emit(
          state.copyWith(error: user.errorMessage, status: LoginStatus.failure),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, error: e.toString()));
    }
  }
}
