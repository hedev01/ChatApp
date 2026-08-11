class GroupState {
  final String groupName;
  GroupState({this.groupName = ''});

  GroupState copyWith({String? groupName}) {
    return GroupState(groupName: groupName ?? this.groupName);
  }
}
