
import 'package:chat_app/features/Auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/auth_user/auth_user_event.dart';
import 'package:chat_app/features/Auth/presentation/bloc/auth_user/auth_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  final GetAuthUserUsecase getUserUsecase;
  AuthUserBloc(this.getUserUsecase) : super(AuthUserState()) {
    on<GetUser>(_getUser);
  
  }

  Future<void> _getUser(GetUser event, Emitter<AuthUserState> emit) async {
    emit(state.copyWith(userStatus: UserStatus.initial));
    try {
      final user = await getUserUsecase();
      if (user.userId.isNotEmpty) {
        emit(
          state.copyWith(userDataEntity: user, userStatus: UserStatus.success),
        );
      } else {
        emit(
          state.copyWith(
            error: "User Not Found",
            userStatus: UserStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), userStatus: UserStatus.failure));
    }
  }

}
