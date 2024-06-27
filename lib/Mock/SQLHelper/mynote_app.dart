import 'package:flutter/material.dart';
import 'package:myapp/Mock/auth/auth_page.dart';

class MynoteApp extends StatelessWidget {
  const MynoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthPage(),
    );
  }
}