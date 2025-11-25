import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import '../controllers/profile_controller.dart';
import '../widget/custom_achievements.dart';
import '../widget/custom_icons.dart';
import '../widget/custom_subcription.dart';

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
                      Text("Sarah Johnson", style: AppTextStyles.spaceGroteskLarge16),
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
                      CustomButton(
                        childText: "Manage Subscription",
                        onTap: () {},
                        buttonColor: AppColors.profileBlack,
                        buttonChildColor: AppColors.profileYellow,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Edit Profile",
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.profileLine,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.profileGray,
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Achievements", style: AppTextStyles.spaceGroteskLarge16),
                      SizedBox(height: 16.h),
                      CustomAchievements(text: "7-Day Streak"),
                      SizedBox(height: 16.h),
                      CustomAchievements(text: "7-Day Streak"),
                      SizedBox(height: 16.h),
                      CustomAchievements(text: "7-Day Streak"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              _buildContainer(),
              SizedBox(height: 32.h),
              _examHistoryContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Container _examHistoryContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.profileGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Exam History", style: AppTextStyles.spaceGroteskMedium20),
            SizedBox(height: 4.h),
            Text(
              "Your recent mock exam results",
              style: AppTextStyles.regular14,
            ),
            SizedBox(height: 24.h),
            CustomSubscription(
              statushigth: 23.h,
              Textpersan: "82%",
              statusWidth: 64.w,
              textTitel: "Exam History",
              textSubTitel: "Feb 10, 2025",
              status: "Passed",
              StatusColor: AppColors.profilePassed,
              TextColor: AppColors.whiteColor,
            ),
            SizedBox(height: 16),
            CustomSubscription(
              statushigth: 23.h,
              Textpersan: "82%",
              statusWidth: 64.w,
              textTitel: "Exam History",
              textSubTitel: "Feb 10, 2025",
              status: "Passed",
              StatusColor: AppColors.profilePassed,
              TextColor: AppColors.whiteColor,
            ),
            SizedBox(height: 16),
            CustomSubscription(
              statushigth: 23.h,
              Textpersan: "82%",
              statusWidth: 64.w,
              textTitel: "Exam History",
              textSubTitel: "Feb 10, 2025",
              status: "Failed",
              StatusColor: AppColors.profileFailed,
              TextColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  Container _buildContainer() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.profileGray,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Subscription Details", style: AppTextStyles.spaceGroteskMedium20),
            SizedBox(height: 4.h),
            Text(
              "Manage your plan and billing",
              style: AppTextStyles.regular14,
            ),
            SizedBox(height: 16.h),
            CustomSubscription(
              statushigth: 28.h,
              statusWidth: 59.w,
              textTitel: "Current Plan",
              textSubTitel: "Monthly",
              status: "Active",
              StatusColor: AppColors.profileActive,
              TextColor: AppColors.whiteColor,
            ),
            SizedBox(height: 16.h),
            CustomSubscription(
              statushigth: 28.h,
              statusWidth: 74.w,
              textTitel: "Renewal Date",
              textSubTitel: "March 15, 2025",
              status: "Upgrade",
              StatusColor: AppColors.profileGray,
              TextColor: AppColors.profileBlack,
            ),
          ],
        ),
      ),
    );
  }
}
