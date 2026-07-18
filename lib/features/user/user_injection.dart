import 'package:chat_app/features/user/data/datasources/local/user_local_data_source.dart';
import 'package:chat_app/features/user/data/datasources/local/user_local_data_source_imp.dart';
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source.dart';
import 'package:chat_app/features/user/data/datasources/remote/user_remote_data_source_imp.dart';
import 'package:chat_app/features/user/data/repositories/user_repository_imp.dart';
import 'package:chat_app/features/user/domain/repositories/user_repository.dart';
import 'package:chat_app/features/user/domain/usecase/get_user_usecase.dart';
import 'package:chat_app/features/user/domain/usecase/get_users_usecase.dart';
import 'package:chat_app/features/user/domain/usecase/save_user_usecase.dart';
import 'package:chat_app/features/user/domain/usecase/update_avatar_usecase.dart';
import 'package:chat_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

void registerUser(GetIt locator){
    /// data source
  locator.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImp());
  locator.registerSingleton<UserLocalDataSource>(UserLocalDataSourceImp());
  
 /// repositories
  locator.registerSingleton<UserRepository>(
    UserRepositoryImp(locator(), locator()),
  );


    ///UseCase
  locator.registerSingleton(GetUsersUsecase(locator.get()));
  locator.registerSingleton(GetUserUsecase(locator.get()));
  locator.registerSingleton(SaveUserUsecase(locator.get()));
  locator.registerSingleton(UpdateAvatarUsecase(locator.get()));


    ///Bloc
  locator.registerSingleton(UserBloc(locator.get()));

}