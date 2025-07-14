import 'package:flutter/material.dart';
import 'package:testing/core/widgets/base_screen.dart';

import '../../../core/config/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      pageTitle: 'Glass Page',
      isScrollable: true,
      isBackButton: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Welcome to Glass UI!", style: AppTextStyle.bold(22)),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text("Action")),
        ],
      ),
    );
    ;
  }
}
