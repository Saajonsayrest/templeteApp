import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../config/app_text_styles.dart';
import '../constants/app_colors.dart';
import 'base_screen.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      isScrollable: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child:
                SizedBox(height: 350.h, width: 300.w, child: Lottie.asset('assets/lottie/no_internet.json')),
          ),
          20.verticalSpace,
          Text(
            'NO INTERNET !',
            style: AppTextStyle.bold(25).copyWith(color: AppColors.primary),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
