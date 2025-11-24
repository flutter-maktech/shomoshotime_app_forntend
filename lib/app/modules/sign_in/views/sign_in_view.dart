import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignInView'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Container(
          width:double.infinity,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            color: AppColors.hintTextColor,
          ),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(ImagePath.signIn,height: 84.h,),
              SizedBox(height: 32.h,
              ),
              Text('Sign In',style: AppTextStyles.bold32,),
              Text('Access your account to continue.',style: AppTextStyles.regular16,),
              SizedBox(height: 32.h,),
              TextField(),

            ],
          ),
        ),
      ),
    );
  }
}
