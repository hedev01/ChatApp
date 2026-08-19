import 'package:chat_app/features/Auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:chat_app/features/Auth/presentation/pages/register_page.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:chat_app/features/group/presentation/cubit/group_cubit.dart';
import 'package:chat_app/core/di/locator.dart';
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
  late GroupCubit groupCubit;
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    chatCubit = context.read<ChatCubit>();
    groupCubit = context.read<GroupCubit>();
    GetAuthUserUsecase authUseCase = GetAuthUserUsecase(locator.get());
    try {
      final user = await authUseCase();

      if (user.userId.isNotEmpty) {
        await chatCubit.connect(user.userId);
        await groupCubit.connectGroup(user.userId);
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
