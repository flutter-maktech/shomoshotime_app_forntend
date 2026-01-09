import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';

class BackGroundContainer extends StatelessWidget {
  const BackGroundContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.homeStack,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
        ),
      ),
    );
  }
}

