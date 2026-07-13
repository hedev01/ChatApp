import 'dart:async';

import 'package:chat_app/core/constans/constans.dart';
import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/data/models/message_model.dart';
import 'package:signalr_netcore/signalr_client.dart';


class ChatRemoteDataSourceImp extends ChatRemoteDataSource {
  late HubConnection connection;
  final controller = StreamController<MessageModel>.broadcast();
  final onlineUser = StreamController<Set<String>>.broadcast();
  final offlineUser = StreamController<Set<String>>.broadcast();
  final onlineUserController = StreamController<List<String>>.broadcast();
  final readController = StreamController<List<Object?>>.broadcast();
  final userTypingController = StreamController<String>.broadcast();
  final userStopTypingController = StreamController<String>.broadcast();

  final Set<String> _onlineUsers = {};

  @override
  Future<void> connect(String userId) async {
    connection = HubConnectionBuilder()
        .withUrl("${Constans.baseUrl}/chatHub?userId=$userId")
        .build();

    connection.on("ReceiveMessage", (args) {
      controller.add(MessageModel.fromHub(args!));
    });

    connection.on("UserOnline", (args) {
      final userId = args![0].toString();
      _onlineUsers.add(userId);
      onlineUser.add(Set.from(_onlineUsers));
    });

    connection.on("UserOffline", (args) {
      final userId = args![0].toString();
      _onlineUsers.remove(userId);
      offlineUser.add(Set.from(_onlineUsers));
    });
    connection.on("OnlineUsers", (args) {
      final users = (args![0] as List).cast<String>();

      onlineUserController.add(users);
    });

    connection.on("ConversationRead", (args) {
   

      readController.add(args ?? []);
    });

    connection.on("UserStartedTyping", (args) {
      final senderId = args![0].toString();

      userTypingController.add(senderId);
    });

    connection.on("UserStoppedTyping", (args) {
      final senderId = args![0].toString();

      userStopTypingController.add(senderId);
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

  @override
  Stream<Set<String>> get offline => offlineUser.stream;

  @override
  Stream<Set<String>> get online => onlineUser.stream;

  @override
  Stream<List<String>> get onlineUsers => onlineUserController.stream;

  @override
  Stream<List<Object?>> get conversationRead => readController.stream;

  @override
  Future<void> markAsRead(String senderId) async {
    await connection.invoke("MarkConversationAsRead", args: [senderId]);
  }

  @override
  Stream<String> get userStopTyping => userStopTypingController.stream;

  @override
  Stream<String> get userTyping => userTypingController.stream;

  @override
  Future<void> startTyping(String receiverId) async {
    await connection.invoke("StartTyping", args: [receiverId]);
  }

  @override
  Future<void> stopTyping(String receiverId)async {
   await connection.invoke("StopTyping", args: [receiverId]);
  }
}
