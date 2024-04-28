import 'package:flutter/material.dart';
import 'package:redmine_tasker/ui/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redmine mobile',
      home: LoginScreen(),
    );
  }
}
