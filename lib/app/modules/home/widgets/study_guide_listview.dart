import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../common_widgets/custom_progress_container.dart';

class StudyGuideListView extends StatelessWidget {
  const StudyGuideListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) => CustomProgressContainer(
        title: 'SPI Study Guide - Chapter 5',
        progress: .8,
        progressComplete: '55% Complete',
      ),
    );
  }
}
