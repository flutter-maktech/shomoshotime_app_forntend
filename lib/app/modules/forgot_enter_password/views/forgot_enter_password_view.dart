import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../all_utils/validators.dart';
import '../controllers/forgot_enter_password_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';

class ForgotEnterPasswordView extends GetView<ForgotEnterPasswordController> {
  const ForgotEnterPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments['email'] ?? '';
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.signIn, height: 84.h),
                      SizedBox(height: 32.h),
                      Text('Reset Password', style: AppTextStyles.bold32),
                      Text(
                        "Enter your new password below to reset it.",
                        style: AppTextStyles.regular16,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),

                      // New Password
                      Obx(
                            () => CustomTextField(
                          hintText: '************',
                          topHintText: 'New Password',
                          controller: controller.addNewPassController,
                          obscureText: controller.isVisibleAddPass.value,
                          suffixIcon: IconButton(
                            onPressed: controller.toggleAddPassVisibility,
                            icon: Icon(
                              controller.isVisibleAddPass.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          validator: AppValidators.password,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Confirm Password
                      Obx(
                            () => CustomTextField(
                          hintText: '************',
                          topHintText: 'Confirm Password',
                          controller: controller.confirmPassController,
                          obscureText: controller.isVisibleConfirmPass.value,
                          suffixIcon: IconButton(
                            onPressed: controller.toggleConfirmPassVisibility,
                            icon: Icon(
                              controller.isVisibleConfirmPass.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                          validator: (value) => AppValidators.confirmPassword(
                            value,
                            controller.addNewPassController.text,
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h),

                      // Save Button
                      Obx(() => CustomButton(
                          childText: controller.isLoading.value
                              ? 'Please wait...'
                              : 'Save New Password',
                          onTap: controller.isLoading.value
                              ? null
                              : () => controller.saveNewPass(email),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
