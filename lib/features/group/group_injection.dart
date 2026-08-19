import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/group/data/data_source/group_remote_data_source.dart';
import 'package:chat_app/features/group/data/data_source/group_remote_data_source_imp.dart';
import 'package:chat_app/features/group/data/repositories/group_repository_imp.dart';
import 'package:chat_app/features/group/domain/repositories/group_repository.dart';
import 'package:chat_app/features/group/domain/usecase/connect_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/create_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/delete_group_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/group_created_usecase.dart';
import 'package:chat_app/features/group/domain/usecase/group_deleted_usecase.dart';
import 'package:chat_app/features/group/presentation/cubit/group_cubit.dart';
import 'package:get_it/get_it.dart';

void registerGroup(GetIt locator) {
  /// data source
  locator.registerSingleton<GroupRemoteDataSource>(GroupRemoteDataSourceImp());

  /// repositories
  locator.registerSingleton<GroupRepository>(GroupRepositoryImp(locator()));
  // Usecases
  locator.registerSingleton(CreateGroupUsecase(locator()));
  locator.registerSingleton(ConnectGroupUsecase(locator()));
  locator.registerSingleton(DeleteGroupUsecase(locator()));
  locator.registerSingleton(GroupCreatedUsecase(locator()));
  locator.registerSingleton(GroupDeletedUseCase(locator()));

  // Cubit
  locator.registerFactory(() => GroupCubit(locator(), locator() , locator() , locator() , locator(),locator<ChatBloc>()));
}
