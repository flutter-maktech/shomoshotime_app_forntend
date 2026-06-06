import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_text_styles.dart';

class CustomDolarPlan extends StatelessWidget {
  final String dolartext;
  final String daytext;
  final Color? color;
  const CustomDolarPlan({
    super.key,
    required this.dolartext,
    required this.daytext,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(dolartext, style: AppTextStyles.bold32.apply(color: color)),
        SizedBox(width: 8.w),
        Text(daytext, style: AppTextStyles.regular14.apply(color: color)),
      ],
    );
  }
}
