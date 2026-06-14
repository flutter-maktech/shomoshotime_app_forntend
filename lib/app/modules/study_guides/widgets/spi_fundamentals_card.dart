import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_progress.dart';
import '../../../routes/app_pages.dart';

class SpiFundamentalsCard extends StatelessWidget {
  final double progressValue;
  final String category,
      cardTitle,
      cardSubtitle,
      pageNumber,
      progressPercentText,
      fileUrl;
  final int contentId;

  const SpiFundamentalsCard({
    super.key,
    required this.pageNumber,
    required this.progressPercentText,
    required this.progressValue,
    required this.category,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.fileUrl,
    required this.contentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarBack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Image.asset(ImagePath.bookImage, scale: 4),
                ),
              ),
              const Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Text(
                    category,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(cardTitle, style: AppTextStyles.bold18),
          // Text(
          //   cardSubtitle,
          //   style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          // ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Image.asset(ImagePath.arrowCircle, scale: 4),
              SizedBox(width: 5.w),
              Text(
                pageNumber,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
              Text(
                progressPercentText,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),
          CustomProgress(progress: progressValue),
          SizedBox(height: 20.h),
          CustomButton(
            childText: 'Continue Reading',
            onTap: () => Get.toNamed(
              Routes.spiFundamentals,
              arguments: {
                'pdfUrl': fileUrl,
                'title': cardTitle,
                'contentId': contentId,
                'lastPage': progressValue == 1.0
                    ? 1
                    : int.tryParse(pageNumber.split('/').first) ?? 1,
              },
            ),
          ),
        ],
      ),
    );
  }
}
