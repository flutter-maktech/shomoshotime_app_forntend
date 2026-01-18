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
                    child: Stack(
                      children: [
                        Obx(() {
                          return CircleAvatar(
                            radius: 80.r,
                            backgroundColor: Colors.grey[200],
                            child: CircleAvatar(
                              radius: 76.r,
                              backgroundColor:
                                  Colors.grey[300], // Background for icon
                              child: controller.selectedImage.value != null
                                  ? CircleAvatar(
                                      radius: 74.r,
                                      backgroundImage: FileImage(
                                        controller.selectedImage.value!,
                                      ),
                                    )
                                  : userImage != null && userImage.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        userImage,
                                        width: 152.w, // 76 * 2
                                        height: 152.w,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              // Show icon if image fails to load
                                              return Icon(
                                                Icons.person,
                                                size: 60.w,
                                                color: Colors.grey[600],
                                              );
                                            },
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 60.w,
                                      color: Colors.grey[600],
                                    ),
                            ),
                          );
                        }),
                        // Edit icon
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.profileYellow,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 3.w,
                              ),
                            ),
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              Icons.edit,
                              size: 20.w,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
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
