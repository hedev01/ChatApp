import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  HubConnection? _connection;

  List<String> messages = [];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  Future<void> connect() async {
    _connection = HubConnectionBuilder()
        .withUrl("http://192.168.1.50:8002/chatHub?userId=user1")
        .build();

    _connection!.on("ReceiveMessage", (args) {
      final sender = args![0].toString();
      final message = args[1].toString();

      setState(() {
        messages.add("$sender: $message");
      });
    });

    await _connection!.start();

    setState(() {
      messages.add("🟢 Connected");
    });
  }

  Future<void> sendMessage() async {
    final text = controller.text;

    await _connection!.invoke(
      "SendMessage",
      args: [
        {"senderId": "user1", "receiverId": "user2", "content": text},
      ],
    );

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(messages[index]));
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: "Message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connection?.stop();
    super.dispose();
  }
}
