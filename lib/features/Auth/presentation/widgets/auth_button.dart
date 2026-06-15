import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.size,
    required this.onPressed,
    this.child
  });

  final Size size;
  final void Function() onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * .07,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child ?? Text('Register'),
      ),
    );
  }
}