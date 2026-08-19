import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:chat_app/features/user/domain/usecase/get_users_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetUsersUsecase userUsecase;

  ChatBloc(this.userUsecase) : super(ChatState()) {
    on<ChatSubmitted>(_getUsers);
    on<RefreshChatList>(_refreshChatList);
  }

  Future<void> _getUsers(
    ChatSubmitted event,
    Emitter<ChatState> emit,
  ) async {
    await _loadUsers(
      event.userId,
      emit,
    );
  }

  Future<void> _refreshChatList(
    RefreshChatList event,
    Emitter<ChatState> emit,
  ) async {
    await _loadUsers(
      event.userId,
      emit,
    );
  }

  Future<void> _loadUsers(
    String userId,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ChatStatus.loading,
      ),
    );

    try {
      final result = await userUsecase(
        userId: userId,
      );

      if (result.isSuccess!) {
        emit(
          state.copyWith(
            user: result.data,
            status: ChatStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            error: result.errorMessage,
            status: ChatStatus.failure,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
