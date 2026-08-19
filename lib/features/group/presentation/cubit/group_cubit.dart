import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/features/group/domain/usecase/connect_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/create_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/delete_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/group_created_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/group_deleted_usecase.dart';
import 'package:chat_app/features/group/presentation/cubit/group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupCubit extends Cubit<GroupState> {
  final ConnectGroupUsecase connectGroupUsecase;
  final CreateGroupUsecase createGroupUsecase;
  final DeleteGroupUsecase deleteGroupUsecase;
  final GroupCreatedUsecase groupCreatedUsecase;
  final GroupDeletedUseCase groupDeletedUsecase;
  final ChatBloc chatBloc;
  GroupCubit(
    this.createGroupUsecase,
    this.connectGroupUsecase,
    this.deleteGroupUsecase,
    this.groupCreatedUsecase,
    this.groupDeletedUsecase,
    this.chatBloc,
  ) : super(GroupState());

  Future<void>connectGroup(String userId) async {
    await connectGroupUsecase(userId);
    groupCreatedUsecase().listen((message) {
      chatBloc.add(RefreshChatList(userId));
      emit(state.copyWith(createGroupMessage: message));
    });
    groupDeletedUsecase().listen((message) {
      chatBloc.add(RefreshChatList(userId));
      emit(state.copyWith(deleteGroupMessage: message));
    });
  }

  Future<void> createGroup(
    String groupName,
    String avatarUrl,
    List<String> members,
    String createdByName,
  ) async {
    await createGroupUsecase(groupName, avatarUrl, members, createdByName);
  }

  Future<void> deleteGroup(String groupId , String groupName) async {
    await deleteGroupUsecase(groupId, groupName);
  }
}
