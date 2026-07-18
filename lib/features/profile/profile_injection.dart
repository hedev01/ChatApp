import 'package:chat_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:chat_app/features/profile/data/datasources/remote/profile_remote_data_source_imp.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repository_imp.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chat_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';

void registerProfile(GetIt locator){
    /// data source
  locator.registerSingleton<ProfileRemoteDataSource>(
    ProfileRemoteDataSourceImp(),
  );

    /// repositories
  locator.registerSingleton<ProfileRepository>(
    ProfileRepositoryImp(locator.get()),
  );

  ///UseCase
  locator.registerSingleton(UploadAvatarUsecase(locator.get()));

    ///Bloc
  locator.registerSingleton(
    ProfileBloc(locator.get(), locator.get(), locator.get()),
  );
}