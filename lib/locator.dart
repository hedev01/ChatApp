

import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source_imp.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source_imp.dart';
import 'package:chat_app/features/Auth/Data/repositories/auth_repository_imp.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// data source
  locator.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImp());
  locator.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImp());

  /// repositories
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImp(locator(), locator()),
  );

  ///UseCase
  locator.registerSingleton(AuthUseCase(locator()));

  ///Bloc
  locator.registerSingleton(RegisterBloc(locator()));
  locator.registerSingleton(LoginBloc(locator()));
}
