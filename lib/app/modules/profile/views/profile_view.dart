import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import '../controllers/profile_controller.dart';
import '../widget/custom_icons.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileView'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.profileGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 32.h,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        ImagePath.profile,
                        width: 160.w,
                        height: 160.h,
                      ),
                      SizedBox(height: 10.h),
                      Text("Sarah Johnson", style: AppTextStyles.medium16),
                      SizedBox(height: 4),
                      Text(
                        "sarah.johnson@example.corn",
                        style: AppTextStyles.regular14,
                      ),
                      SizedBox(height: 24),
                      Image.asset(
                        ImagePath.profilePremium,
                        height: 36.h,
                        width: 117.w,
                      ),
                      SizedBox(height: 16.h),
                      Divider(color: AppColors.profileLine, height: 2.h),
                      SizedBox(height: 16.h),
                      CustomProfileDistyle(
                        icon: Icons.mail_outlined,
                        text: "sarah.johnson@example.com",
                      ),
                      SizedBox(height: 12.h),
                      CustomProfileDistyle(
                        icon: Icons.calendar_today,
                        text: "Member since January 2024",
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          Image.asset(
                            ImagePath.profileNotebook,
                            height: 20.h,
                            width: 20.w,
                          ),
                          SizedBox(width: 8.w),
                          Text("Monthly Plan", style: AppTextStyles.regular12),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Divider(color: AppColors.profileLine, height: 2.h),
                      SizedBox(height: 16.h),
                      Container(
                        height: 48.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColors.profileBlack,
                        ),
                        child: Center(
                          child: Text(
                            "Manage Subscription",
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.profileYellow,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Text("Edit Profile",style:AppTextStyles.regular14.copyWith(color: AppColors.profileLine),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
