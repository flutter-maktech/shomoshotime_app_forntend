import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

import '../controllers/edit_profile_controller.dart';
import '../widget/custom_edit_profile_textfield.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    ImagePath.profile,
                    height: 160.h,
                    width: 160.w,
                  ),
                ),
                SizedBox(height: 46.h),
                Text("Full name", style: AppTextStyles.regular12),
                SizedBox(height: 8.h),
                CustomEditProfileTextField(text: "Katona Beatrix"),
                SizedBox(height: 16.h),
                Text("Email", style: AppTextStyles.regular12),
                SizedBox(height: 8.h),
                CustomEditProfileTextField(text: "deanna.curtis@example.com"),
                SizedBox(height: 16.h),
                CustomButton(
                  childText: "Manage Subscription",
                  buttonChildColor: AppColors.profileYellow,
                  buttonColor: AppColors.blackColor,
                  onTap: () => Get.toNamed(Routes.SUBSCRIPTION_PLAN),
                ),
                SizedBox(height: 158.h,),
                CustomButton(
                  childText: "Save",
                  buttonChildColor: AppColors.blackColor,
                  buttonColor: AppColors.profileYellow,
                  onTap: () => Get.offAllNamed(Routes.PROFILE)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
