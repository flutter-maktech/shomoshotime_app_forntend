import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../all_utils/validators.dart';
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                    controller: controller.nameController,
                    hintText: 'Enter your full name',
                    topHintText: 'Name',
                    keyboardType: TextInputType.text,
                    validator: (val) =>
                        val == null || val.isEmpty ? "Name is required" : null,
                  ),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'youremail@here',
                    topHintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email,
                  ),
                  Obx(
                    () => CustomTextField(
                      hintText: '**********',
                      topHintText: 'Password',
                      controller: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isVisiblePass.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isVisiblePassOnTap();
                        },
                        icon: Icon(
                          controller.isVisiblePass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      validator: AppValidators.password,
                    ),
                  ),
                  Obx(
                    () => CustomTextField(
                      hintText: '**********',
                      topHintText: 'Confirm Password',
                      controller: controller.confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.isVisibleConfirmPass.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isVisibleConfirmPassOnTap();
                        },
                        icon: Icon(
                          controller.isVisibleConfirmPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                      validator: (value) => AppValidators.confirmPassword(
                        value,
                        controller.passwordController.text,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        controller.signUp();
                      },
                      child: CustomButton(
                        childText: controller.isLoading.value
                            ? 'Please wait...'
                            : "Sign Up",
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomRichText(
                    firstText: 'Already have an account ?',
                    secondText: 'Sign In',
                    onTap: () {
                      Get.toNamed(Routes.SIGN_IN);
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
