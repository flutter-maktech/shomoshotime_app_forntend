import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/forgot_enter_password_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../utils/validators.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';


class ForgotEnterPasswordView extends GetView<ForgotEnterPasswordController> {
  const ForgotEnterPasswordView({super.key});
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
                  child: Form(
                    key: controller.formKey,
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
                        Obx(
                              () => CustomTextField(
                            hintText: '************',
                            topHintText: 'Add new password',
                            controller: controller.addNewPassController,
                            obscureText: controller.isVisibleAddPass.value,
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isVisibleAddPassOnTap();
                              },
                              icon: Icon(
                                controller.isVisibleAddPass.value
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
                            controller: controller.confirmPassController,
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
                              controller.addNewPassController.text,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        InkWell(
                          onTap: () {
                            controller.saveNewPass();
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
        ),
      );
  }
}
