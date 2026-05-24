import 'package:flutter/material.dart';
import 'package:beautygovn/features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const BeautyGoApp());
}

class BeautyGoApp extends StatelessWidget {
  const BeautyGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeautyGo VN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF151B36)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
