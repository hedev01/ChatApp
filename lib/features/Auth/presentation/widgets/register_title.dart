import 'package:flutter/material.dart';

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Create Your\n Account",
      style: TextStyle(fontSize: 35, color: Color(0xff323142)),
    );
  }
}