import 'package:signalr_netcore/signalr_client.dart';

class ChatService {
  HubConnection? _connection;

  Future<void> connect(String userId) async {
    _connection = HubConnectionBuilder()
        .withUrl("http://192.168.1.50:8002/chatHub?userId=$userId")
        .build();

    _connection!.on("ReceiveMessage", (arguments) {
      if (arguments == null) return;

      final senderId = arguments[0].toString();
      final message = arguments[1].toString();

      print("FROM: $senderId");
      print("MESSAGE: $message");
    });

    await _connection!.start();

    print("Connected");
  }

  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
  }) async {
    await _connection!.invoke(
      "SendMessage",
      args: [senderId, receiverId, message],
    );
  }

  Future<void> disconnect() async {
    await _connection?.stop();
  }
}
