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
    this.hasBackButton = true,
    this.onRefresh,
  });

  final Widget child;
  final bool isScrollable;
  final bool? hasBackButton;
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
        backgroundColor: Colors.white.withOpacity(0.9),
        appBar: hasAppBar
            ? AppBar(
                backgroundColor: AppColors.primary,
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
                leading: hasBackButton!
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
        body: Padding(
          padding: EdgeInsets.only(top: hasAppBar ? 0 : statusBarHeight, left: 15.w, right: 15.w),
          child: SafeArea(
            bottom: true, // ensure bottom safe area is respected
            child: isScrollable
                ? SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height -
                                (hasAppBar ? kToolbarHeight : statusBarHeight)),
                        child: child,
                      ),
                    ),
                  )
                : Center(child: child),
          ),
        ),
      ).monitorConnection(),
    );
  }
}
