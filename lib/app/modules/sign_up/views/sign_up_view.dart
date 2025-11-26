import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_rich_text.dart';
import '../../common_widgets/custom_text_field.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 40.h),
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.containerColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImagePath.signIn, height: 84.h),
                SizedBox(height: 32.h),
                Text('Sign Up', style: AppTextStyles.bold32),
                Text(
                  'Access your account to continue.',
                  style: AppTextStyles.regular16,
                ),
                SizedBox(height: 31.h),
                CustomTextField(
                  hintText: 'youremail@here',
                  topHintText: 'Email',
                ),
                CustomTextField(
                  hintText: '**********',
                  topHintText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                ),
                CustomTextField(
                  hintText: '**********',
                  topHintText: 'Confirm Password',
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                ),
                InkWell(
                    onTap: (){
                      Get.toNamed(Routes.ENTER_CODE);

                    },
                    child: CustomButton(childText: "Sign Up")),
                CustomRichText(firstText: 'Already Have an account ?', secondText: 'Sign In',
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
