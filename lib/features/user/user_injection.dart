
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source.dart';
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source_imp.dart';
import 'package:chat_app/features/user/data/repositories/user_repository_imp.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';
import 'package:chat_app/features/user/domain/usecase/get_users_usecase.dart';
import 'package:get_it/get_it.dart';

void registerUser(GetIt locator){
    /// data source
  locator.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImp());
  
 /// repositories
  locator.registerSingleton<UserRepository>(
    UserRepositoryImp(locator()),
  );


    ///UseCase
  locator.registerSingleton(GetUsersUsecase(locator.get()));


    
}