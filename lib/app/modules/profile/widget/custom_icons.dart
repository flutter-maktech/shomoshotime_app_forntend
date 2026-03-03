import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class CustomProfileDistyle extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool shouldBold;
  final Function()? onTap;
  final Color color;
  final Color textColor;

  const CustomProfileDistyle({
    super.key,
    required this.text,
    required this.icon,
    this.shouldBold = false,
    this.onTap,
    this.color = AppColors.profileIcons,
    this.textColor = AppColors.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color),
          SizedBox(width: 8),
          Text(
            text,
            style: shouldBold
                ? AppTextStyles.bold14.apply(color: textColor)
                : AppTextStyles.regular12.apply(color: textColor),
          ),
        ],
      ),
    );
  }
}
