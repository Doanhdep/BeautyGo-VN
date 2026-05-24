import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold_placeholder.dart';

class HomeFeedScreen extends StatelessWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldPlaceholder(
        title: 'Home Feed',
        subtitle: 'TikTok-style beauty short video feed placeholder.',
      ),
    );
  }
}
