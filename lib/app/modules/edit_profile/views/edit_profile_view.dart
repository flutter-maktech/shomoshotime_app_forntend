import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';

import '../controllers/edit_profile_controller.dart';
import '../widget/custom_edit_profile_textfield.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final argu = Get.arguments as Map<String, dynamic>;
    final userImage = argu['userImage'];
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
                  child: GestureDetector(
                    onTap: controller.pickImage,
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 80.r,
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!)
                                  as ImageProvider<Object>
                            : NetworkImage(userImage) as ImageProvider<Object>,
                      );
                    }),
                  ),
                ),

                SizedBox(height: 46.h),
                Text("Full name", style: AppTextStyles.regular12),
                SizedBox(height: 8.h),
                CustomEditProfileTextField(
                  text: "Katona Beatrix",
                  controller: controller.nameController,
                ),
                SizedBox(height: 16.h),
                Text("Email", style: AppTextStyles.regular12),
                SizedBox(height: 8.h),
                CustomEditProfileTextField(
                  controller: controller.emailController,
                  text: "deanna.curtis@example.com",
                ),
                SizedBox(height: 100),
                CustomButton(
                  childText: "Save",
                  buttonChildColor: AppColors.blackColor,
                  buttonColor: AppColors.profileYellow,
                  onTap: () async {
                    final success = await controller.updateProfile();
                    print('---------$success');
                    if (success == true) {
                      Get.back(result: true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
