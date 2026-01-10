// study_guide_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../widgets/audio_player_widget.dart';

class StudyGuideCard extends StatelessWidget {
  
  const StudyGuideCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 18.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarBack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Image.asset(
                    ImagePath.bookImage,
                    scale: 4,
                  ),
                ),
              ),
              Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  child: Text(
                    "SPI",
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 10.h),
          
          // Title and description
          Text(
            'SPI Fundamentals',
            style: AppTextStyles.bold18,
          ),
          
          Text(
            'Master the core principles of ultrasound physics and',
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.appBarSub,
            ),
          ),
          
          SizedBox(height: 15.h),
          
          // Audio player
          AudioPlayerWidget(),
          
          SizedBox(height: 20.h),
          
          // Continue button
          CustomButton(
            onTap: () {
              Get.toNamed(Routes.AUDIO_PLAY_CARD);
            },
            childText: 'Continue to listen',
          ),
        ],
      ),
    );
  }
}