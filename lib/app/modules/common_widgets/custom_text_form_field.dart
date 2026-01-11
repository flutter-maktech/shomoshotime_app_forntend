import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/app_colors.dart';
import '../study_guides/controllers/study_guides_controller.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudyGuidesController>();
    
    return Obx(() {
      final hintText = controller.select.value == 0 
          ? 'Search PDF study guides...' 
          : 'Search audio study guides...';
      
      return TextFormField(
        controller: controller.searchController,
        onChanged: controller.onSearchChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.search, size: 16),
          filled: true,
          fillColor: AppColors.appBarBack,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
          suffixIcon: controller.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, size: 16),
                  onPressed: controller.clearSearch,
                )
              : null,
        ),
      );
    });
  }
}
