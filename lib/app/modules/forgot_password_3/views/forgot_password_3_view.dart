import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../controllers/forgot_password_3_controller.dart';

class ForgotPassword3View extends GetView<ForgotPassword3Controller> {
  const ForgotPassword3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.signIn, height: 84.h),
                    SizedBox(height: 32.h),
                    Text('Forgot Password ', style: AppTextStyles.bold32),
                    Text(
                      "Enter your email to reset your password.",
                      style: AppTextStyles.regular16,
                      textAlign: TextAlign.center,
                    ),
                    CustomTextField(
                      hintText: '************',
                      topHintText: 'Add new password',
                    ),
                    CustomTextField(
                      hintText: '**********',
                      topHintText: 'Confirm Password',
                      suffixIcon: Icon(Icons.visibility_off_outlined),
                    ),
                    SizedBox(height: 16.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.SIGN_IN);
                      },
                      child: CustomButton(childText: 'Save new password'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
