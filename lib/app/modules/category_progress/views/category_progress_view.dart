import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_progress_container.dart';
import '../controllers/category_progress_controller.dart';

class CategoryProgressView extends GetView<CategoryProgressController> {
  const CategoryProgressView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Category Progress',
        subTitle: 'Your mastery across specialties',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 5.h),
        child: ListView.builder(
          itemCount: 15,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) => CustomProgressContainer(
            title: 'SPI Study Guide - Chapter 5',
            suffixTitle: '156 / 240',
            progress: .8,
            progressComplete: '55% Complete',
          ),
        ),
      ),
    );
  }
}
