import 'package:flutter/cupertino.dart';
import 'package:testing/core/widgets/base_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(pageTitle: 'Home', child: Text('H O M E S C R E E N'));
  }
}
