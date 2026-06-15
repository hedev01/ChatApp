import 'package:chat_app/features/Auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key , required this.passwordCtr});
  final TextEditingController passwordCtr;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityCubit, bool>(
      builder: (context, isVisible) {
        return TextField(
          controller: passwordCtr,
          obscureText: !isVisible,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock, size: 25),
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                context.read<PasswordVisibilityCubit>().toggle();
              },
            ),
            hintText: "Password",
          ),
        );
      },
    );
  }
}
