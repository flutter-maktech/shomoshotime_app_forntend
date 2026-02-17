import 'package:flutter/material.dart';

import '../../../data/app_colors.dart';

class CustomAddCard extends StatelessWidget {
  final String text;
  const CustomAddCard({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor,
        hintText: text,
      ),
    );
  }
}
