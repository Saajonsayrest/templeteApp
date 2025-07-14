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
    this.isBackButton = false,
    this.onRefresh,
    this.blurSigma = 20,
    this.opacity = 0.08,
  });

  final Widget child;
  final bool isScrollable;
  final bool? isBackButton;
  final String? pageTitle;
  final Widget? drawer;
  final Widget? customSuffixAppBar;
  final void Function()? onRefresh;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerState;
  final double blurSigma;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final hasAppBar = pageTitle != null;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldMessengerState ?? scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white, // No gradient behind AppBar
        appBar: hasAppBar
            ? AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          title: Text(
            pageTitle!,
            style: AppTextStyle.medium(25).copyWith(color: AppColors.buttonText),
          ),
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
          leading: isBackButton!
              ? (drawer != null
              ? IconButton(
            icon: const Icon(Icons.menu, color: AppColors.secondary),
            onPressed: () => scaffoldKey?.currentState?.openDrawer(),
          )
              : const SizedBox.shrink())
              : IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
            onPressed: () => context.pop(),
          ),
        )
            : null,
        drawer: drawer != null ? Drawer(child: drawer!) : null,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEAF3FB), // Very light sky blue
                Color(0xFFF7FAFD), // Almost white with a blue tint
                Color(0xFFDDEAF6), // Misty blue-gray
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),


          child: Padding(
            padding: EdgeInsets.only(
              top: hasAppBar ? kToolbarHeight + MediaQuery.of(context).padding.top : 0,
            ),
            child: isScrollable
                ? SingleChildScrollView(child: child)
                : child,
          ),
        ),
      ).monitorConnection(),
    );
  }
}
