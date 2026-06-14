class RegisterRequestEntity {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterRequestEntity({
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}