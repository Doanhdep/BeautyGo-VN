import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold_placeholder.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldPlaceholder(
        title: 'Auth Screen',
        subtitle:
            'Firebase email/password + Google login flow sẽ triển khai ở phase feature.',
      ),
    );
  }
}
