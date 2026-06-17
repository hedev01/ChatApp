abstract class RegisterEvent {}

class RegisterSubmitted
    extends RegisterEvent {

  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  RegisterSubmitted({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}