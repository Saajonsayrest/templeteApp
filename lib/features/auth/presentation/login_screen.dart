import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testing/core/extensions/padding_extensions.dart';
import 'package:testing/core/widgets/base_screen.dart';
import 'package:testing/core/widgets/custom_button.dart';
import '../../../core/utils/validators.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);

    void submit() {
      if (formKey.currentState!.validate()) {
        print('Email: ${emailController.text}');
        print('Password: ${passwordController.text}');
      }
    }

    return BaseScreen(
      title: 'Login',
      scrollable: true,
      showBackButton: false,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Icon(Icons.apple, size: 100.h).pB(100.h),
            // Email Field
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                prefixIcon: const Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
            ),
            SizedBox(height: 20.h),

            // Password Field
            TextFormField(
              controller: passwordController,
              obscureText: obscurePassword.value,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword.value ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    obscurePassword.value = !obscurePassword.value;
                  },
                ),
              ),
              validator: Validators.validatePassword,
            ),
            SizedBox(height: 30.h),
            CustomButton(
              onPressed: () {},
              isLoading: false,
              text: 'Login',
            ),
          ],
        ).pX(15.w),
      ),
    );
  }
}
