import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import '../controllers/session_expired_controller.dart';

class SessionExpiredView extends GetView<SessionExpiredController> {
  const SessionExpiredView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history_toggle_off_rounded,
                size: 80.h,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 24.h),
              Text(
                'Session Expired',
                style: AppTextStyles.medium24.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Your session has expired. Please log in again to continue.',
                textAlign: TextAlign.center,
                style: AppTextStyles.regular14.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 48.h),
              CustomButton(
                childText: 'Login Again',
                onTap: controller.logoutAndRedirect,
                buttonColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
