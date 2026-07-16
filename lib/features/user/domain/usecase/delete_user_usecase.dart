import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class DeleteUserUsecase {
  final UserRepository repository;
  DeleteUserUsecase(this.repository);
  Future<void> call() {
    return repository.delete();
  }
}
