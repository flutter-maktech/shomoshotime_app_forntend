import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class CustomProfileDistyle extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomProfileDistyle({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(flex: 1,child: Icon(icon, color: AppColors.profileIcons)),
        SizedBox(width: 8),
        Flexible(flex: 1,child: Text(text, style: AppTextStyles.regular12,overflow: TextOverflow.ellipsis,)),

      ],
    );
  }
}
