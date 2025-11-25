import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';

class SelectedPlanActivity extends StatelessWidget {
  final String text;
  const SelectedPlanActivity({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check),
        SizedBox(width: 2.5.w),
        Text(text,style: AppTextStyles.regular16,),
      ],
    );
  }
}
