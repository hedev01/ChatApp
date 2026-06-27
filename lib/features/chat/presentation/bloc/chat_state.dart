import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState {
  final ChatStatus status;
  final List<GetUserDataEntity>? user;
  final String? error;
  ChatState({this.status = ChatStatus.initial, this.user, this.error});

  ChatState copyWith({ChatStatus? status, List<GetUserDataEntity>? user, String? error}) {
    return ChatState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
