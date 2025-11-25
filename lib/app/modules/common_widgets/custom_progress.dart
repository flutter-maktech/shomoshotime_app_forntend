import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';

class CustomProgress extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color? backgroundColor;
  final double? height;

  const CustomProgress({
    super.key,
    required this.progress,
    this.backgroundColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 8.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.progressBg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          children: [
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.whiteColor, AppColors.primaryColor],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
