import 'package:chat_app/chat_page.dart';
import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/features/Auth/Data/repositories/auth_repository_imp.dart';
import 'package:chat_app/features/Auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_bloc.dart';
import 'package:chat_app/features/Auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:chat_app/features/Auth/presentation/pages/register_page.dart';
import 'package:chat_app/features/Auth/presentation/pages/splash_screen.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/global_widget/error_message_widget.dart';
import 'package:chat_app/locator.dart';
import 'package:chat_app/signalr_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Hive.initFlutter();
  setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
        BlocProvider(create: (_) => RegisterBloc(locator.get())),
        BlocProvider(create: (_) => LoginBloc(locator.get()),),
        BlocProvider(create: (_) => ChatBloc(locator.get()),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: SplashScreen(),
    );
  }
}
