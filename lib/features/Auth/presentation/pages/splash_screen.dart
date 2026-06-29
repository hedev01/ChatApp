import 'package:chat_app/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:chat_app/features/Auth/presentation/pages/register_page.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../chat/presentation/cubit/chat_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ChatCubit chatCubit;
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
     chatCubit = context.read<ChatCubit>();
    AuthUseCase authUseCase = AuthUseCase(locator.get());
    try {
      final user = await authUseCase.getUser();

      if (user.userId.isNotEmpty) {
        await chatCubit.connect(user.userId);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return ChatListPage(userId: user.userId);
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return RegisterPage();
            },
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return RegisterPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Hedev01', style: TextStyle(fontSize: 45))),
    );
  }
}
