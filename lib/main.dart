import 'package:chat_app/chat_page.dart';
import 'package:chat_app/core/theme/app_theme.dart';
import 'package:chat_app/features/Auth/presentation/pages/register_page.dart';
import 'package:chat_app/signalr_client.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: RegisterPage(),
    );
  }
}
