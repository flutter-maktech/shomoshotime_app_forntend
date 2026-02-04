import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/notification/controllers/notification_controller.dart';
import '../custom_bottom_navigation_bar/controllers/custom_bottom_navigation_bar_controller.dart';

class PrimaryAppBar extends StatelessWidget {
  final void Function()? notificationOnTap;
  final void Function()? profileOnTap;

  const PrimaryAppBar({super.key, this.notificationOnTap, this.profileOnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(ImagePath.appLogo, height: 38.h),
          Row(
            children: [
              InkWell(
                onTap: notificationOnTap,
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.appBarCircleAvatarColor,
                      child: Padding(
                        padding: EdgeInsets.all(6.sp),
                        child: Image.asset(ImagePath.notification),
                      ),
                    ),
                    Obx(() {
                      final notificationController =
                          Get.find<NotificationController>();
                      if (notificationController.hasUnread) {
                        return Positioned(
                          right: 2.w,
                          top: 2.h,
                          child: Container(
                            height: 16.h,
                            width: 16.w,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                notificationController.unreadCount > 9
                                    ? '9+'
                                    : '${notificationController.unreadCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ],
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: AppColors.appBarCircleAvatar,
                child: Padding(
                  padding: const EdgeInsets.all(2.5),
                  child: InkWell(
                    onTap: profileOnTap,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Obx(() {
                        final navCtrl =
                            Get.find<CustomBottomNavigationBarController>();
                        final imageUrl = navCtrl.profileImageUrl.value;
                        if (imageUrl.isNotEmpty) {
                          print('✅✅$imageUrl');
                          return Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: double.infinity,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  ImagePath.profile,
                                  fit: BoxFit.cover,
                                ),
                          );
                        }
                        return Image.asset(
                          ImagePath.profile,
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
