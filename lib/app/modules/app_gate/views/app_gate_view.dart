import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import '../controllers/app_gate_controller.dart';

class AppGateView extends GetView<AppGateController> {
  const AppGateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const CircularProgressIndicator(
              color: AppColors.primaryColor,
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.readColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.checkSubscription(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            );
          }

          return const CircularProgressIndicator(color: AppColors.primaryColor);
        }),
      ),
    );
  }
}
