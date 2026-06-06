import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class SectionHeaderRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onViewAllTap;

  const SectionHeaderRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.onViewAllTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.spaceGroteskMedium20,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              subtitle,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.appBarSub,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        InkWell(
          onTap: onViewAllTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Text(
              'View All',
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.primaryGray,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}