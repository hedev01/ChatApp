import 'package:chat_app/features/chat/domain/usecases/chat_usecase.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUsecase chatUsecase;
  ChatBloc(this.chatUsecase) : super(ChatState()) {
    on<ChatSubmitted>(_getUsers);
  }
  Future<void> _getUsers(ChatSubmitted event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading));

    try {
      final user = await chatUsecase.getUsers(event.userId);
      if (user.isSuccess!) {
        emit(state.copyWith(user: user.data, status: ChatStatus.success));
      } else {
        emit(
          state.copyWith(error: user.errorMessage, status: ChatStatus.failure),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: ChatStatus.failure, error: e.toString()));
    }
  }
}
