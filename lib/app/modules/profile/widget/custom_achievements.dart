import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';

class CustomAchievements extends StatelessWidget {
  final String text;
  const CustomAchievements({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),child: Padding(
      padding:  EdgeInsets.all(8.sp),
      child: Row(children: [
        Image.asset(ImagePath.profileCupLogo),
        SizedBox(width: 8.w,),
        Text(text,style: AppTextStyles.regular14,)

      ],),
    ),
    );
  }
}
