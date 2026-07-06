import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source_imp.dart';
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
import 'package:chat_app/features/chat/domain/usecases/chat_usecase.dart';
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
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  /// data source
  locator.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImp());
  locator.registerSingleton<AuthLocalDataSource>(AuthLocalDataSourceImp());
  locator.registerSingleton<ChatRemoteDataSource>(ChatRemoteDataSourceImp());

  /// repositories
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImp(locator(), locator()),
  );
  locator.registerSingleton<ChatRepository>(ChatRepositoryImp(locator()));

  ///UseCase
  locator.registerSingleton(AuthUseCase(locator()));
  locator.registerSingleton(ChatUsecase(locator()));
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

  ///Bloc
  locator.registerSingleton(RegisterBloc(locator()));
  locator.registerSingleton(LoginBloc(locator()));
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
      locator.get()
    ),
  );
}
