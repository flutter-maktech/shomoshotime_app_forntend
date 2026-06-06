import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/app_colors.dart';
import '../../data/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String? topHintText;
  final String hintText;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.topHintText,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topHintText ?? '',
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.hintTextColor,
            ),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            textInputAction: textInputAction,
            cursorColor: AppColors.profileLine,

            onFieldSubmitted: onFieldSubmitted,

            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
              hintStyle: AppTextStyles.regular16.copyWith(
                color: AppColors.hintTextColor,
              ),
              suffixIcon: suffixIcon,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
