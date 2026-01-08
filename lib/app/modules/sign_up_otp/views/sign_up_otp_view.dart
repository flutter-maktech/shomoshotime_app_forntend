import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../all_utils/validators.dart';
import '../controllers/sign_up_otp_controller.dart';

class SignUpOtpView extends GetView<SignUpOtpController> {
  const SignUpOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 40.h,
                  ),
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
                        Image.asset(ImagePath.signIn, height: 70.h),
                        SizedBox(height: 20.h),
                        Text('Enter code', style: AppTextStyles.bold32),
                        Text(
                          "Didn't received OTP?",
                          style: AppTextStyles.regular16,
                        ),
                        // Resend
                        Obx(
                              () => InkWell(
                            onTap: controller.enableResend.value
                                ? controller.resendOtp
                                : null,
                            child: Text(
                              controller.enableResend.value
                                  ? 'Resend code'
                                  : 'Resend in ${controller.secondsRemaining}s',
                              style: AppTextStyles.regular16.copyWith(
                                color: controller.enableResend.value
                                    ? AppColors.primaryColor
                                    : Colors.grey,
                                decoration: TextDecoration.underline,
                                decorationColor: controller.enableResend.value ?  AppColors.primaryColor : AppColors.containerColor ,
                              ),
                            ),
                          ),
                        ),
                        // OTP Input
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Pinput(
                            controller: controller.otpController,
                            length: 4,
                            keyboardType: TextInputType.number,
                            validator: AppValidators.otp,
                            defaultPinTheme: PinTheme(
                              height: 50.h,
                              width: 55.w,
                              textStyle: AppTextStyles.bold20.copyWith(
                                color: AppColors.blackColor,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        // button
                        Padding(
                          padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                          child: InkWell(
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                Get.offAllNamed(Routes.ONBOARDING);
                              }
                            },
                            child: Obx(
                                  () => CustomButton(
                                childText: controller.isLoading.value
                                    ? 'Please wait...'
                                    : 'Next',
                                onTap: controller.verifyOtp,
                              ),
                            ),
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
      ),
    );
  }
}
