import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final VoidCallback onTap;
  const AuthFooter({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: const TextStyle(color: Color(0xff323142), fontSize: 16),
        children: [
          TextSpan(
            text: "Sign In",
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
