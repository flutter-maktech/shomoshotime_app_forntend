import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class FlashCardFilterBar extends StatelessWidget {
  const FlashCardFilterBar({
    super.key,
    required this.title,
    required this.index,
    this.onTap,
    required this.isSelected,
  });

  final String title;
  final int index;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            title,
            style: AppTextStyles.regular13.copyWith(
              color: isSelected ? Colors.black : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
