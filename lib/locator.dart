import 'package:chat_app/core/services/upload/picker_repository.dart';
import 'package:chat_app/core/services/upload/picker_repository_imp.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/remote/auth_remote_data_source_imp.dart';
import 'package:chat_app/features/Auth/Data/repositories/auth_repository_imp.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_bloc.dart';
import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source.dart';
import 'package:chat_app/features/chat/data/datasources/remote/chat_remote_data_source_imp.dart';
import 'package:chat_app/features/chat/data/repositories/chat_repository_imp.dart';
import 'package:chat_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/features/chat/domain/usecases/connect_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/mark_as_read_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/offline_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/online_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/online_users_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/read_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/receive_messages_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/start_typing_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/stop_chat_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/stop_typing_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/user_is_typing_usecase.dart';
import 'package:chat_app/features/chat/domain/usecases/user_stop_typing_usecase.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:chat_app/features/profile/data/datasources/remote/profile_remote_data_source_imp.dart';
import 'package:chat_app/features/profile/data/repositories/profile_repository_imp.dart';
import 'package:chat_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chat_app/features/profile/domain/usecases/upload_avatar_usecase.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/upload/data/datasource/remote/upload_file_data_source.dart';
import 'package:chat_app/features/upload/data/datasource/remote/upload_file_data_source_imp.dart';
import 'package:chat_app/features/upload/data/repositories/upload_file_repository_imp.dart';
import 'package:chat_app/features/upload/domain/repositories/upload_file_repository.dart';
import 'package:chat_app/features/upload/domain/usecase/upload_file_usecase.dart';
import 'package:chat_app/features/upload/presentation/bloc/upload_file_bloc.dart';
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

GetIt locator = GetIt.instance;

void setup() {
  /// data source
  locator.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImp());
  locator.registerSingleton<ChatRemoteDataSource>(ChatRemoteDataSourceImp());
  locator.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImp());
  locator.registerSingleton<UserLocalDataSource>(UserLocalDataSourceImp());
  locator.registerSingleton<ProfileRemoteDataSource>(
    ProfileRemoteDataSourceImp(),
  );
  locator.registerSingleton<UploadFileDataSource>(UploadFileDataSourceImp());

  /// repositories
  locator.registerSingleton<AuthRepository>(AuthRepositoryImp(locator()));
  locator.registerSingleton<ChatRepository>(ChatRepositoryImp(locator()));
  locator.registerSingleton<UserRepository>(
    UserRepositoryImp(locator(), locator()),
  );
  locator.registerSingleton<ProfileRepository>(
    ProfileRepositoryImp(locator.get()),
  );
  locator.registerSingleton<UploadFileRepository>(
    UploadFileRepositoryImp(locator.get()),
  );

  ///UseCase
  locator.registerSingleton(AuthUseCase(locator()));
  locator.registerSingleton(SendMessageUsecase(locator()));
  locator.registerSingleton(ReceiveMessagesUseCase(locator()));
  locator.registerSingleton(ConnectChatUseCase(locator.get()));
  locator.registerSingleton(StopChatUsecase(locator.get()));
  locator.registerSingleton(OnlineUsecase(locator.get()));
  locator.registerSingleton(OfflineUsecase(locator.get()));
  locator.registerSingleton(OnlineUsersUsecase(locator.get()));
  locator.registerSingleton(MarkAsReadUsecase(locator.get()));
  locator.registerSingleton(ReadUsecase(locator.get()));
  locator.registerSingleton(UserIsTypingUsecase(locator.get()));
  locator.registerSingleton(UserStopTypingUsecase(locator.get()));
  locator.registerSingleton(StartTypingUsecase(locator.get()));
  locator.registerSingleton(StopTypingUsecase(locator.get()));
  locator.registerSingleton(GetUsersUsecase(locator.get()));
  locator.registerSingleton(GetUserUsecase(locator.get()));
  locator.registerSingleton(SaveUserUsecase(locator.get()));
  locator.registerSingleton(UploadAvatarUsecase(locator.get()));
  locator.registerSingleton(UpdateAvatarUsecase(locator.get()));
  locator.registerSingleton(UploadFileUsecase(locator.get()));

  ///Services
  locator.registerSingleton<PickerRepository>(PickerRepositoryImp());

  ///Bloc
  locator.registerSingleton(RegisterBloc(locator(), locator()));
  locator.registerSingleton(LoginBloc(locator(), locator()));
  locator.registerSingleton(ChatBloc(locator()));
  locator.registerSingleton(
    ChatCubit(
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
      locator.get(),
    ),
  );
  locator.registerSingleton(UserBloc(locator.get()));
  locator.registerSingleton(
    ProfileBloc(locator.get(), locator.get(), locator.get()),
  );
  locator.registerSingleton(UploadFileBloc(locator.get()));
}
