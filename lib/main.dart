import 'package:chat_app/core/services/lifecycle_service.dart';
import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/features/Auth/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/features/Auth/presentation/bloc/register/register_bloc.dart';
import 'package:chat_app/features/Auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:chat_app/features/Auth/presentation/pages/splash_screen.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  setup();
  final lifecycle = LifecycleService(locator.get());
  lifecycle.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
        BlocProvider(create: (_) => RegisterBloc(locator.get())),
        BlocProvider(create: (_) => LoginBloc(locator.get())),
        BlocProvider(create: (_) => ChatBloc(locator.get())),
        BlocProvider(
          create: (_) => ChatCubit(
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
        ),
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
