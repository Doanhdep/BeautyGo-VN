import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold_placeholder.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppScaffoldPlaceholder(
        title: 'Upload',
        subtitle: 'Video upload flow placeholder for creators and salons.',
      ),
    );
  }
}
