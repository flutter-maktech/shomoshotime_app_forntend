import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/image_path.dart';

class CustomEditProfileTextField extends StatelessWidget {
  final String text;
  const CustomEditProfileTextField({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: AppColors.editProfileTextField,
        hintText: text,
        suffix: Image.asset(
          ImagePath.editProfileIcon,
          height: 22.h,
          width: 22.w,
        ),
      ),
    );
  }
}
