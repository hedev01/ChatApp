import 'dart:async';
import 'dart:convert';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/data/models/get_user_model.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:http/http.dart' as http;
import 'package:signalr_netcore/signalr_client.dart';

class ChatRemoteDataSourceImp extends ChatRemoteDataSource {
  late HubConnection connection;

  final controller = StreamController<MessageModel>.broadcast();
  @override
  Future<GetUserModel> getUsers(String userId) async {
    GetUserModel? data;
    try {
      final response = await http
          .get(
            Uri.parse("${Constans.baseUrl}/api/User/GetUsers?userId=$userId"),
          )
          .timeout(Duration(seconds: Constans.timeOut));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        data = GetUserModel.fromJson(json);
      }
    } on TimeoutException {
      throw TimeoutException(
        "Api: ${Constans.baseUrl}/api/User/GetUsers?userId=$userId =>> TimeOut",
      );
    }
    return data!;
  }

  @override
  Future<void> connect(String userId) async {
    connection = HubConnectionBuilder()
        .withUrl("${Constans.baseUrl}/chatHub?userId=$userId")
        .build();

    connection.on("ReceiveMessage", (args) {
      controller.add(MessageModel.fromHub(args!));
    });

    await connection.start();
  }

  @override
  Stream<MessageModel> get messages => controller.stream;

  @override
  Future<void> send(MessageModel message) async {
    await connection.invoke("SendMessage", args: [message.toJson()]);
  }

  @override
  Future<void> stop() async {
    if (connection.state != HubConnectionState.Disconnected) {
      await connection.stop();
    }
  }
}
