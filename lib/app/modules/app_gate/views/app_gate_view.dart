import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/app_gate_controller.dart';

class AppGateView extends GetView<AppGateController> {
  const AppGateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            bool isNetworkError = controller.errorMessage.value.contains('SocketException') || 
                                  controller.errorMessage.value.contains('Failed host lookup') ||
                                  controller.errorMessage.value.contains('ClientException');
            
            String title = isNetworkError ? 'No Internet Connection' : 'Something went wrong';
            String description = isNetworkError 
                ? 'Please check your internet connection and try again.' 
                : controller.errorMessage.value;
            IconData icon = isNetworkError ? Icons.wifi_off_rounded : Icons.error_outline_rounded;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 80.h,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    title,
                    style: AppTextStyles.medium24.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular14.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 48.h),
                  CustomButton(
                    childText: 'Retry',
                    onTap: () => controller.checkSubscription(),
                    buttonColor: AppColors.primaryColor,
                  ),
                ],
              ),
            );
          }

          return const CircularProgressIndicator(color: AppColors.primaryColor);
        }),
      ),
    );
  }
}
