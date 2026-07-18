import 'package:chat_app/features/upload/data/datasource/remote/upload_file_data_source.dart';
import 'package:chat_app/features/upload/data/datasource/remote/upload_file_data_source_imp.dart';
import 'package:chat_app/features/upload/data/repositories/upload_file_repository_imp.dart';
import 'package:chat_app/features/upload/domain/repositories/upload_file_repository.dart';
import 'package:chat_app/features/upload/domain/usecase/upload_file_usecase.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_bloc.dart';
import 'package:get_it/get_it.dart';

void registerUpload(GetIt locator){
    /// data source
  locator.registerSingleton<UploadFileDataSource>(UploadFileDataSourceImp());

  /// repositories
  locator.registerSingleton<UploadFileRepository>(
    UploadFileRepositoryImp(locator.get()),
  );

  ///UseCase
  locator.registerSingleton(UploadFileUsecase(locator.get()));



  ///Bloc
  locator.registerSingleton(UploadFileBloc(locator.get()));
}