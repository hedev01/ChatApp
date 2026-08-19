class GroupState {
  final String createGroupMessage;
  final String deleteGroupMessage;
  GroupState({this.createGroupMessage = '', this.deleteGroupMessage = ''});

  GroupState copyWith({String? createGroupMessage, String? deleteGroupMessage}) {
    return GroupState(
      createGroupMessage: createGroupMessage ?? this.createGroupMessage,
      deleteGroupMessage: deleteGroupMessage ?? this.deleteGroupMessage,
    );
  }
}
