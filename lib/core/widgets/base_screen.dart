import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../config/app_text_styles.dart';
import '../extensions/no_internet_extension.dart';
import '../extensions/padding_extensions.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.child,
    this.title,
    this.drawer,
    this.trailing,
    this.onRefresh,
    this.scrollable = true,
    this.showBackButton = true,
    this.backgroundColor,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.applyHorizontalPadding = true,
  });

  final Widget child;

  /// AppBar
  final String? title;
  final Widget? drawer;
  final Widget? trailing;
  final VoidCallback? onRefresh;
  final bool showBackButton;

  /// Layout
  final bool scrollable;
  final bool applyHorizontalPadding;
  final Color? backgroundColor;

  /// Extras
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final bool hasAppBar = title != null;
    final bool hasDrawer = drawer != null;

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      resizeToAvoidBottomInset: true,
      drawer: hasDrawer ? Drawer(child: drawer!) : null,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      appBar: hasAppBar
          ? AppBar(
              backgroundColor: AppColors.primary,
              elevation: 0,
              centerTitle: true,
              title: Text(
                title!,
                style: AppTextStyle.medium(20).copyWith(color: AppColors.white),
              ),
              leading: hasDrawer
                  ? Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: AppColors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    )
                  : showBackButton
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColors.white),
                          onPressed: () => context.pop(),
                        )
                      : null,
              actions: [
                if (onRefresh != null)
                  IconButton(
                    icon: const Icon(Icons.autorenew, color: AppColors.white),
                    onPressed: onRefresh,
                  ).pR(8.w)
                else if (trailing != null)
                  trailing!.pR(8.w),
              ],
            )
          : null,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: applyHorizontalPadding ? EdgeInsets.symmetric(horizontal: 16.w) : EdgeInsets.zero,
            child: scrollable
                ? LayoutBuilder(
                    builder: (_, constraints) {
                      return SingleChildScrollView(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: child,
                        ),
                      );
                    },
                  )
                : child,
          ),
        ),
      ),
    ).monitorConnection();
  }
}
