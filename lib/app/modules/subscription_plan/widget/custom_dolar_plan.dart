import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_text_styles.dart';

class CustomDolarPlan extends StatelessWidget {
  final String Dolartext;
  final String Daytext;
  const CustomDolarPlan({
    super.key,
    required this.Dolartext,
    required this.Daytext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(Dolartext, style: AppTextStyles.bold32),
        SizedBox(width: 8.w),
        Text(Daytext, style: AppTextStyles.regular12),
      ],
    );
  }
}
