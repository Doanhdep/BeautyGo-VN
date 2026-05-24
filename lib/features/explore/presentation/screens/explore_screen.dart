import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold_placeholder.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldPlaceholder(
        title: 'Explore',
        subtitle: 'Discover salons, beauty creators, and trends placeholder.',
      ),
    );
  }
}
