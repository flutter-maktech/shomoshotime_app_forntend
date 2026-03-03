import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_text_field.dart';

import '../controllers/delete_account_controller.dart';

class DeleteAccountView extends GetView<DeleteAccountController> {
  const DeleteAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Delete Account',
        subTitle: "We're sorry to see you go",
        onTap: () => Get.back(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.containerColor,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: AppColors.readColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.readColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: AppColors.readColor,
                            size: 24.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "Warning!",
                            style: AppTextStyles.bold16.copyWith(
                              color: AppColors.readColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Deleting your account is permanent. All of your data, including progress, certificates, and personal information, will be removed across all our services and cannot be recovered.",
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Text("Confirm Deletion", style: AppTextStyles.bold18),
                SizedBox(height: 8.h),
                Text(
                  "Please enter your email and password to confirm that you want to delete your account.",
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.appBarSub,
                  ),
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: controller.emailController,
                  topHintText: "Email",
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!GetUtils.isEmail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    topHintText: "Password",
                    hintText: "Enter your password",
                    obscureText: controller.isVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.appBarSub,
                      ),
                      onPressed: () => controller.visibleOnTap(),
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                Obx(
                  () => CustomButton(
                    childText: controller.isLoading.value
                        ? 'Please wait...'
                        : "Delete My Account",
                    onTap: controller.isLoading.value
                        ? null
                        : () => controller.deleteAccount(),
                    buttonColor: AppColors.readColor,
                    buttonChildColor: AppColors.whiteColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "I want to stay",
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.appBarSub,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
