import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class SaveUserUsecase {
  final UserRepository userRepository;
  SaveUserUsecase(this.userRepository);
  Future<void> call(UserDataEntity user){
    return userRepository.saveUser(user);
  }
}