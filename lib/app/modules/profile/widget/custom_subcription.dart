import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class CustomSubscription extends StatelessWidget {
  final String textTitel;
  final String textSubTitel;
  final String status;
  final Color? StatusColor;
  final Color? TextColor;
  final double? statusWidth;
  final double? statushigth;
  final String? Textpersan;

  const CustomSubscription({
    super.key,
    required this.textTitel,
    required this.textSubTitel,
    required this.status,
    this.StatusColor = AppColors.profileActive,
    this.TextColor = AppColors.whiteColor,
    this.statusWidth,
    this.Textpersan, this.statushigth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(textTitel, style: AppTextStyles.spaceGroteskMedium16),
                Text(textSubTitel, style: AppTextStyles.regular12),
              ],
            ),
            Column(
              children: [
                if (Textpersan != null)
                  Text(Textpersan!, style: AppTextStyles.spaceGroteskMedium32),
                SizedBox(height: 5.h),
                Container(
                  height: statushigth,
                  width: statusWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: StatusColor,
                  ),
                  child: Center(
                    child: Text(
                      status,
                      style: AppTextStyles.regular14.copyWith(color: TextColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
