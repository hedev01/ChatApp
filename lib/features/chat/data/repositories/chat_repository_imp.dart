import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/domain/entities/get_user_entity.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImp extends ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  ChatRepositoryImp(this.chatRemoteDataSource);
  @override
  Future<GetUserEntity> getUsers(String userId) async {
    return await chatRemoteDataSource.getUsers(userId);
  }
}
