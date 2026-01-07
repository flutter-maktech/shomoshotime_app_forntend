import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_text_field.dart';
import 'package:shomoshotime/app/utils/validators.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../controllers/forgot_enter_email_controller.dart';

class ForgotEnterEmailView extends GetView<ForgotEnterEmailController> {
  const ForgotEnterEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.containerColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        hintText: 'youremail@here',
                        topHintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validator: AppValidators.email,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                        child: CustomButton(
                          childText: 'Send code',
                          onTap: () {
                            controller.forgotSendCode();
                          },
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
