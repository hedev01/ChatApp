import 'package:chat_app/features/download/data/data_source/local/download_local_data_source.dart';
import 'package:chat_app/features/download/data/data_source/local/download_local_data_source_imp.dart';
import 'package:chat_app/features/download/data/data_source/remote/download_remote_data_source.dart';
import 'package:chat_app/features/download/data/data_source/remote/download_remote_data_source_imp.dart';
import 'package:chat_app/features/download/data/repositories/download_repository_imp.dart';
import 'package:chat_app/features/download/domain/repositories/download_repository.dart';
import 'package:chat_app/features/download/domain/usecase/download_usecase.dart';
import 'package:chat_app/features/download/domain/usecase/is_downloaded_usecase.dart';
import 'package:chat_app/features/download/domain/usecase/open_file_usecase.dart';
import 'package:chat_app/features/download/presentation/cubit/download_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

void registerDownload(GetIt locator) {
  // External
  locator.registerLazySingleton<Dio>(() => Dio());

  /// data source

  locator.registerLazySingleton<DownloadRemoteDataSource>(
    () => DownloadRemoteDataSourceImpl(locator()),
  );
  locator.registerLazySingleton<DownloadLocalDataSource>(
    () => DownloadLocalDataSourceImpl(),
  );

  /// repositories
  locator.registerLazySingleton<DownloadRepository>(
    () => DownloadRepositoryImp(locator(), locator()),
  );

  ///UseCase
  locator.registerLazySingleton(() => DownloadUsecase(locator()));

  locator.registerLazySingleton(() => OpenFileUseCase(locator()));

  locator.registerLazySingleton(() => IsDownloadedUseCase(locator()));

  ///Bloc

  locator.registerFactory(() => DownloadCubit(locator(), locator(), locator()));
}
