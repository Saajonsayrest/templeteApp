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
    this.scaffoldKey,
    this.backgroundColor,
  });

  final Widget child;
  final String? title;
  final Widget? drawer;
  final Widget? trailing;
  final VoidCallback? onRefresh;
  final bool scrollable;
  final bool showBackButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final hasAppBar = title != null;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? AppColors.white,
      resizeToAvoidBottomInset: true,
      drawer: drawer != null ? Drawer(child: drawer!) : null,
      appBar: hasAppBar
          ? AppBar(
              backgroundColor: AppColors.primary,
              centerTitle: true,
              elevation: 0,
              title: Text(
                title!,
                style: AppTextStyle.medium(20).copyWith(color: AppColors.secondary),
              ),
              leading: drawer != null
                  ? IconButton(
                      icon: const Icon(Icons.menu, color: AppColors.secondary),
                      onPressed: () => scaffoldKey?.currentState?.openDrawer(),
                    )
                  : showBackButton
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColors.secondary),
                          onPressed: () => context.pop(),
                        )
                      : null,
              actions: [
                if (onRefresh != null)
                  IconButton(
                    icon: const Icon(Icons.autorenew, color: AppColors.secondary),
                    onPressed: onRefresh,
                  ).pR(8.w)
                else if (trailing != null)
                  trailing!.pR(8.w),
              ],
            )
          : null,
      body: SafeArea(
        bottom: true,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
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
