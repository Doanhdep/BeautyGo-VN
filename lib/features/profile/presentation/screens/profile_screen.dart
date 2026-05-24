import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold_placeholder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldPlaceholder(
        title: 'Profile',
        subtitle: 'User/Salon profile module placeholder.',
      ),
    );
  }
}
