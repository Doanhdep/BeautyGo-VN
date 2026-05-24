import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold_placeholder.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldPlaceholder(
        title: 'Inbox',
        subtitle: 'Realtime chat placeholder using Firestore streams.',
      ),
    );
  }
}
