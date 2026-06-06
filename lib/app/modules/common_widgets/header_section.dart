// header_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/app_colors.dart';
import '../../data/app_text_styles.dart';
import '../study_guides/widgets/custom_toggle_button.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          'Study Guides',
          style: AppTextStyles.medium20.copyWith(color: AppColors.blackColor),
        ),
        Text(
          'Comprehensive study materials for all specialties',
          style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 56.h,
          width: double.infinity,
          child: const CustomToggleButton(),
        ),
      ],
    );
  }
}
