import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/features/auth/presentation/login_screen.dart';

import '../../features/auth/presentation/register_screen.dart';
import '../../features/home/presentation/home_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) => smoothTransition(const HomeScreen(), state),
  ),
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => smoothTransition(const LoginScreen(), state),
  ),
  GoRoute(
    path: '/register',
    pageBuilder: (context, state) => smoothTransition(const RegisterScreen(), state),
  )
]);

// Function to create the smoothest transition
CustomTransitionPage smoothTransition(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const curve = Curves.fastOutSlowIn; // Ultra-smooth, buttery transition

      var fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
      var scaleTween = Tween<double>(begin: 0.97, end: 1.0).chain(CurveTween(curve: curve));
      var blurTween = Tween<double>(begin: 5.0, end: 0.0).chain(CurveTween(curve: curve));

      return FadeTransition(
        opacity: animation.drive(fadeTween),
        child: ScaleTransition(
          scale: animation.drive(scaleTween),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: blurTween.evaluate(animation), sigmaY: blurTween.evaluate(animation)),
            child: child,
          ),
        ),
      );
    },
  );
}
