import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/primary_app_bar.dart';
import '../controllers/home_controller.dart';
import '../widget/home_view_grid.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 188,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.homeStack,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
              ),
              Column(
                children: [
                  SafeArea(child: PrimaryAppBar()),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 15.h,
                    ),
                    padding: EdgeInsets.all(16.sp),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.homeStack,
                          blurRadius: 10,
                          spreadRadius: 8,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,\nSarah!",
                          style: AppTextStyles.spaceGroteskMedium20,
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        HomeViewGrid(),



                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
