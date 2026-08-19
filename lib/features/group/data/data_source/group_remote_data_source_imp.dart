import 'dart:async';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/group/data/data_source/group_remote_data_source.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class GroupRemoteDataSourceImp implements GroupRemoteDataSource {
  late HubConnection connection;
  final _groupCreatedController = StreamController<String>.broadcast();
  final _groupDeletedController = StreamController<String>.broadcast();
  @override
  Future<void> connect(String userId) async {
    connection = HubConnectionBuilder()
        .withUrl("${Constans.baseUrl}/groupHub?userId=$userId")
        .build();
    connection.on("GroupCreated", (args) {
      _groupCreatedController.add(args?[0].toString() ?? "");
    });
    connection.on("GroupDeleted", (args) {
      _groupDeletedController.add(args?[0].toString() ?? "");
    });
    await connection.start();
  }

  @override
  Future<void> createGroup(
    String groupName,
    String avatarUrl,
    List<String> members,
    String createdByName,
  ) async {
    await connection.invoke(
      "CreateGroup",
      args: [
        {
          "name": groupName,
          "avatarUrl": avatarUrl,
          "memberIds": members,
          "createdByName": createdByName,
        },
      ],
    );
  }

  @override
  Future<void> deleteGroup(String groupId, String groupName) async {
    await connection.invoke("DeleteGroup", args: [groupId, groupName]);
  }

  @override
  Stream<String> get groupCreated => _groupCreatedController.stream;

  @override
  Stream<String> get groupDeleted => _groupDeletedController.stream;
}
