import 'package:chat_app/features/user/domain/entity/user_entity.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class GetUserUsecase {
  final UserRepository userRepository;
  GetUserUsecase(this.userRepository);
Future<UserDataEntity> call(){
  return userRepository.getUser();
}

}