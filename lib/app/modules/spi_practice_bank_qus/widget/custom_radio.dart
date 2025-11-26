import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class CustomRadio extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  const CustomRadio({super.key, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title ?? '',style: AppTextStyles.medium12),
            IconButton(onPressed: onPressed, icon: Icon(Icons.radio_button_checked,color: AppColors.subscriptionPlanButton,),),
          ],
        ),
      ),
    );
  }
}
