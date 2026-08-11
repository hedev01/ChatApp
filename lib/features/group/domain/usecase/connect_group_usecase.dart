import 'package:chat_app/features/group/domain/repositories/group_repository.dart';

class ConnectGroupUsecase {
  final GroupRepository _repository;
  ConnectGroupUsecase(this._repository);
  Future<void> call(String userId)async{
    return _repository.connect(userId);
  }
}