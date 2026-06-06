import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../common_widgets/custom_app_bar.dart';

import '../../common_widgets/custom_progress_container.dart';
import '../controllers/continue_learning_controller.dart';

class ContinueLearningView extends GetView<ContinueLearningController> {
  const ContinueLearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Continue Learning',
        subTitle: 'Pick up where you left off',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 5.h),
        child: ListView.builder(
          itemCount: 15,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) => const CustomProgressContainer(
            title: 'SPI Study Guide - Chapter 5',
            subTitleContainerText: 'Study',
            subTitleText: '2 Hours Ago',
            progress: .7,
          ),
        ),
      ),
    );
  }
}
