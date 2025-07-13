import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/core/extensions/no_internet_extension.dart';
import 'package:testing/core/extensions/padding_extensions.dart';

import '../config/app_text_styles.dart';
import '../constants/app_colors.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.child,
    this.isScrollable = true,
    this.pageTitle,
    this.drawer,
    this.customSuffixAppBar,
    this.scaffoldKey,
    this.scaffoldMessengerState,
    this.isHomeScreen = false,
    this.onRefresh,
  });

  final Widget child;
  final bool isScrollable;
  final bool? isHomeScreen;
  final String? pageTitle;
  final Widget? drawer, customSuffixAppBar;
  final void Function()? onRefresh;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerState;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final hasAppBar = pageTitle != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldMessengerState ?? scaffoldKey,
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: hasAppBar
            ? AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(pageTitle!, style: AppTextStyle.medium(25).copyWith(color: AppColors.secondary)),
          centerTitle: true,
          actions: [
            if (onRefresh != null)
              GestureDetector(
                onTap: onRefresh,
                child: const Icon(Icons.autorenew, color: AppColors.secondary).pR(20.w),
              )
            else if (customSuffixAppBar != null)
              customSuffixAppBar!
          ],
          leading: isHomeScreen!
              ? (drawer != null
              ? IconButton(
              icon: const Icon(Icons.menu, color: AppColors.secondary),
              onPressed: () => scaffoldKey?.currentState?.openDrawer())
              : const SizedBox.shrink())
              : IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
              onPressed: () => context.pop()),
        )
            : null,
        drawer: drawer != null ? Drawer(child: drawer!) : null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB5C6E0), Color(0xFFECE9E6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: GlassContainer(
              padding: const EdgeInsets.all(24),
              child: isScrollable
                  ? SingleChildScrollView(
                child: child,
              )
                  : child,
            ),
          ),
        ),
      ).monitorConnection(),
    );
  }
}



class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blurSigma;
  final Gradient? gradient;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 25,
    this.blurSigma = 20,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: gradient ??
                LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
