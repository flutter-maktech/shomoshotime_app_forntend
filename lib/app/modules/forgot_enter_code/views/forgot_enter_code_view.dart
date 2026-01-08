import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/forgot_enter_code_controller.dart';

class ForgotEnterCodeView extends GetView<ForgotEnterCodeController> {
  const ForgotEnterCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
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
                      Text('Enter code', style: AppTextStyles.bold32),
                      Text(
                        "Didn't received OTP?",
                        style: AppTextStyles.regular16,
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Text(
                          'Resend code',
                          style: AppTextStyles.regular16.copyWith(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 105.w),
                        child: Divider(
                          color: AppColors.primaryColor,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        child: Pinput(
                          length: 4,
                          keyboardType: TextInputType.number,
                          defaultPinTheme: PinTheme(
                            height: 50.h,
                            width: 55.w,
                            textStyle: AppTextStyles.bold16.copyWith(
                              color: AppColors.blackColor,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: InkWell(
                          onTap: () {
                            Get.offAllNamed(Routes.FORGOT_ENTER_PASSWORD);
                          },
                          child: CustomButton(childText: 'Next'),
                        ),
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
