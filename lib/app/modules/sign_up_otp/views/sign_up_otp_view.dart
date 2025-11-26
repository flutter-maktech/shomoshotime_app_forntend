import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_text_field.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.signIn, height: 84.h),
                      SizedBox(height: 32.h),
                      Text('Enter code ', style: AppTextStyles.bold32),
                      Text(
                        "Didn't received OTP?",
                        style: AppTextStyles.regular16,
                      ),
                      Text(
                        'Resend code',
                        style: AppTextStyles.regular16.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 105.w),
                        child: Divider(color: AppColors.primaryColor,thickness: 2,),
                      ),
                     CustomTextField(hintText: '**********',),

                      Padding(
                        padding:  EdgeInsets.only(top: 30.h,bottom: 40.h),
                        child: InkWell(
                          onTap: (){

                            Get.toNamed(Routes.FORGOT_PASSWORD);
                          },

                            child: CustomButton(childText: 'Confirm')),
                      )


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
