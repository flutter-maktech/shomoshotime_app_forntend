import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class CustomSubscription extends StatelessWidget {
  final String textTitel;
  final String textSubTitel;
  final String status;
  final Color? statusColor;
  final Color? textColor;
  final double? statusWidth;
  final double? statushigth;
  final String? textpersan;

  const CustomSubscription({
    super.key,
    required this.textTitel,
    required this.textSubTitel,
    required this.status,
    this.statusColor = AppColors.profileActive,
    this.textColor = AppColors.whiteColor,
    this.statusWidth,
    this.textpersan,
    this.statushigth,
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
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textTitel,
                    style: AppTextStyles.spaceGroteskMedium16,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(textSubTitel, style: AppTextStyles.regular12),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  if (textpersan != null)
                    Text(
                      textpersan!,
                      style: AppTextStyles.spaceGroteskMedium32,
                      overflow: TextOverflow.ellipsis,
                    ),
                  SizedBox(height: 5.h),
                  Container(
                    height: statushigth,
                    width: statusWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: statusColor,
                    ),
                    child: Center(
                      child: Text(
                        status,
                        style: AppTextStyles.regular14.copyWith(
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
