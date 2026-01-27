import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import '../controllers/explore_plan_controller.dart';

class ExplorePlanView extends GetView<ExplorePlanController> {
  const ExplorePlanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomButton(
            childText: 'Explore Plan',
            onTap: () {
              Get.toNamed(Routes.SUBSCRIPTION_PLAN);
            },
          ),
        ),
      ),
    );
  }
}
