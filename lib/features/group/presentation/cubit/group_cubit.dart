import 'package:chat_app/features/group/domain/usecase/connect_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/create_group_usecase.dart';
import 'package:chat_app/features/group/presentation/cubit/group_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupCubit extends Cubit<GroupState> {
  final ConnectGroupUsecase connectGroupUsecase;
  final CreateGroupUsecase createGroupUsecase;
  GroupCubit(this.createGroupUsecase, this.connectGroupUsecase)
    : super(GroupState());

  Future<void> connectGroup(String userId) async {
    await connectGroupUsecase(userId);
  }

  Future<void> createGroup(
    String groupName,
    String avatarUrl,
    List<String> members,
  ) async {
    await createGroupUsecase(groupName, avatarUrl, members);
  }
}
