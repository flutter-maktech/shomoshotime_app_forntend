import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/image_path.dart';

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
              CircleAvatar(
                backgroundColor: AppColors.appBarCircleAvatarColor,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: InkWell(
                    onTap: notificationOnTap,
                    child: Image.asset(ImagePath.notification),
                  ),
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
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Image.asset(ImagePath.profile, fit: BoxFit.cover),
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
