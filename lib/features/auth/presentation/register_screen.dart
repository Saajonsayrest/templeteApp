import 'package:flutter/material.dart';
import 'package:testing/core/widgets/base_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Register',
      scrollable: false,
      showBackButton: true,
      child: Column(
        children: [],
      ),
    );
    ;
  }
}
