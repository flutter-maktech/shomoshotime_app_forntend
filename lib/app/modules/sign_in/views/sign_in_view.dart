import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_rich_text.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import 'package:shomoshotime/app/utils/validators.dart';

import '../../common_widgets/custom_text_field.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(ImagePath.signIn, height: 84.h),
                  SizedBox(height: 16.h),
                  Text('Sign In', style: AppTextStyles.bold32),
                  Text(
                    'Access your account to continue.',
                    style: AppTextStyles.regular16,
                  ),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'youremail@here',
                    topHintText: 'Email',
                    // validator: (val) => (val == null || val.isEmpty)
                    //     ? "Enter your email"
                    //     : null,
                    validator: AppValidators.email,
                  ),
                  Obx(
                    () => CustomTextField(
                      controller: controller.passwordController,
                      hintText: '**********',
                      topHintText: 'Password',
                      obscureText: controller.isVisible.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.visibleOnTap();
                        },
                        icon: Icon(
                          controller.isVisible.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      validator: AppValidators.password,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.FORGOT_PASSWORD);
                      },
                      child: Text(
                        'Forgot password?',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bold14.copyWith(
                          color: AppColors.blueColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomButton(
                    childText: 'Sign In',
                    onTap: () {
                      controller.signIn();
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.blackColor)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.h),
                        child: Text(
                          'Or',
                          style: AppTextStyles.regular16.copyWith(
                            color: AppColors.hintTextColor,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: AppColors.blackColor)),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Image.asset(
                              ImagePath.googleLogo,
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                          SizedBox(width: 9.w),
                          Text(
                            'Sign In With Google',
                            style: AppTextStyles.regular16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomRichText(
                    firstText: "Don't have ony account?",
                    secondText: 'Sign Up',
                    onTap: () {
                      Get.toNamed(Routes.SIGN_UP);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
