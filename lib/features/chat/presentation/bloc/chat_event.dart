abstract class ChatEvent {}

class ChatSubmitted extends ChatEvent {
  final String userId;
  ChatSubmitted({required this.userId});
}
