import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_text_styles.dart';

class SelectedPlanActivity extends StatelessWidget {
  final String text;
  const SelectedPlanActivity({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Flexible(flex: 1,child: Icon(Icons.check)),
        SizedBox(width: 2.5.w),
        Flexible(flex: 6,child: Text(text,style: AppTextStyles.regular16,overflow: TextOverflow.ellipsis,)),
      ],
    );
  }
}
