import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/group/data/data_source/group_remote_data_source.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class GroupRemoteDataSourceImp implements GroupRemoteDataSource {
  late HubConnection connection;
  @override
  Future<void> connect(String userId) async {
    connection = HubConnectionBuilder()
        .withUrl("${Constans.baseUrl}/groupHub?userId=$userId")
        .build();
    connection.on("GroupCreated", (arguments) {
      print("GroupCreated: $arguments");
    });
    await connection.start();
  }

  @override
  Future<void> createGroup(
    String groupName,
    String avatarUrl,
    List<String> members,
  ) async {
    await connection.invoke(
      "CreateGroup",
      args: [
        {"name": groupName, "avatarUrl": avatarUrl, "memberIds": members},
      ],
    );
  }
}
