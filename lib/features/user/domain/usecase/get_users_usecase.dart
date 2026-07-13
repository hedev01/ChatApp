import 'package:chat_app/features/user/domain/entity/get_user_entity.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';

class GetUsersUsecase {
  final UserRepository userRepository;
  GetUsersUsecase(this.userRepository);
  Future<GetUserEntity> call(String userId) async {
    return await userRepository.getUsers(userId);
  }
}
