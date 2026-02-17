import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import '../controllers/profile_controller.dart';
import '../widget/custom_icons.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Profile',
        subTitle: "Manage your account and track your progress",
        onTap: () => Get.toNamed(Routes.CUSTOM_BOTTOM_NAVIGATION_BAR),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Obx(() {
            if (controller.isLoading.value) {
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (controller.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(
                  'An Error Occoured: ${controller.errorMessage.value} ',
                ),
              );
            }
            final profileData = controller.profileResponse.value?.data;
            final userName = profileData?.name;
            final userEmail = profileData?.email;
            final userImage = profileData?.image;
            final memberSince = controller.formatToMonthYear(
              profileData?.createdAt,
            );

            return Column(
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
                        CircleAvatar(
                          backgroundColor: AppColors.appBarCircleAvatar,
                          maxRadius: 80,
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: userImage != null && userImage.isNotEmpty
                                    ? Image.network(
                                        userImage,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, _, _) {
                                          return Container(
                                            color: Colors.grey.shade300,
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.grey.shade600,
                                            ),
                                          );
                                        },
                                      )
                                    : Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey.shade300,
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          userName ?? 'No user name found',
                          style: AppTextStyles.spaceGroteskLarge16,
                        ),
                        SizedBox(height: 4),
                        Text(
                          userEmail ?? 'No email found.',
                          style: AppTextStyles.regular14,
                          overflow: TextOverflow.ellipsis,
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
                          text: userEmail ?? 'N/A',
                        ),
                        SizedBox(height: 12.h),
                        CustomProfileDistyle(
                          icon: Icons.calendar_today,
                          text: "Member since $memberSince",
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
                            Text(
                              "Monthly Plan",
                              style: AppTextStyles.regular12,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Divider(color: AppColors.profileLine, height: 2.h),
                        SizedBox(height: 16.h),
                        CustomButton(
                          childText: "Manage Subscription",
                          onTap: () => Get.toNamed(Routes.SUBSCRIPTION_PLAN),
                          buttonColor: AppColors.profileBlack,
                          buttonChildColor: AppColors.profileYellow,
                        ),
                        SizedBox(height: 16.h),
                        _buillOutlineButton(
                          "Edit Profile",
                          Icons.mode_edit_outline_outlined,
                          () async {
                            final result = await Get.toNamed(
                              Routes.EDIT_PROFILE,
                              arguments: {'userImage': userImage},
                            );

                            if (result == true) {
                              controller.fetchProfileData();
                            }
                          },
                        ),

                        SizedBox(height: 16.h),
                        _buillOutlineButton(
                          "Log Out",
                          Icons.logout_outlined,
                          () {
                            controller.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  SizedBox _buillOutlineButton(
    String buttonText,
    IconData buttonIcon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(buttonText),
        ),
        icon: Icon(buttonIcon, size: 30),
        iconAlignment: IconAlignment.end,
      ),
    );
  }
}
