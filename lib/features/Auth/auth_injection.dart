import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source_imp.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source_imp.dart';
import 'package:chat_app/features/Auth/Data/repositories/auth_repository_imp.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_delete_user_usecase.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_save_user_usecase.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_update_avatar_usecase.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/auth_user/auth_user_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_bloc.dart';
import 'package:get_it/get_it.dart';

void registerAuth(GetIt locator) {
  /// data source
  locator.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImp());
  locator.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImp());

  /// repositories
  locator.registerSingleton<AuthRepository>(AuthRepositoryImp(locator() , locator()));

  ///UseCase
  locator.registerSingleton(AuthUseCase(locator()));
  locator.registerSingleton(AuthSaveUserUsecase(locator()));
  locator.registerSingleton(GetAuthUserUsecase(locator()));
  locator.registerSingleton(AuthDeleteUserUsecase(locator()));
  locator.registerSingleton(AuthUpdateAvatarUsecase(locator()));

  ///Bloc
  locator.registerSingleton(RegisterBloc(locator(), locator()));
  locator.registerSingleton(LoginBloc(locator(), locator()));
  locator.registerSingleton(AuthUserBloc(locator()));
}
