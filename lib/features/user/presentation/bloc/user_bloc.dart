import 'package:chat_app/features/user/domain/usecase/get_user_usecase.dart';
import 'package:chat_app/features/user/presentation/bloc/user_event.dart';
import 'package:chat_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUsecase getUserUsecase;
  UserBloc(this.getUserUsecase) : super(UserState()) {
    on<UserEvent>(_getUser);
  }

  Future<void> _getUser(UserEvent event, Emitter<UserState> emit) async {
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
