import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/primary_app_bar.dart';

import '../../../routes/app_pages.dart';
import '../controllers/flash_cards_controller.dart';

class FlashCardsView extends GetView<FlashCardsController> {
  const FlashCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PrimaryAppBar(
                notificationOnTap: () => Get.toNamed(Routes.NOTIFICATION),
                profileOnTap: () => Get.toNamed(Routes.PROFILE),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Flashcards',
                      style: AppTextStyles.medium20.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    Text(
                      'Master key concepts with interactive flashcards',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.appBarSub,
                      ),
                    ),
                    const SizedBox(height: 16),
                    searchButtonWidget(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.h),
                child: Container(
                  color: AppColors.appBarBack,
                  width: double.infinity,
                  height: 50.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildContainer('All', 0),
                          buildContainer('SPI', 1),
                          buildContainer('Vascular', 2),
                          buildContainer('OB/GYN', 3),
                          buildContainer('Abdomen', 4),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: spiFundamentalsCardWidget(),
                );
              }, childCount: 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget spiFundamentalsCardWidget() {
    return Container(
      width: double.infinity,
      // height: 400,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarBack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Image.asset(ImagePath.bookImage, scale: 4),
                ),
              ),
              Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    "SPI",
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text('SPI Fundamentals', style: AppTextStyles.bold18),
          Text(
            'Master the core principles of ultrasound physics and',
            style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Image.asset(ImagePath.layerImage, scale: 4),
              SizedBox(width: 5.w),
              Text(
                '50 cards',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset(ImagePath.vectorImage, scale: 4),
              SizedBox(width: 5.w),
              Text(
                '9 saved',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                'Progress',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
              Spacer(),
              Text(
                '38/50',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(6),
            minHeight: 8,
            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
            backgroundColor: AppColors.whiteColor,
            value: 0.5,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            childText: 'Continue Studying',
            onTap: () => Get.toNamed(Routes.VASCULAR_FLASHCARDS),
          ),
        ],
      ),
    );
  }

  GestureDetector buildContainer(String title, int index) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: controller.selectIndex.value == index
              ? AppColors.primaryColor
              : AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Text(
            title,
            style: AppTextStyles.regular13.copyWith(
              color: controller.selectIndex.value == index
                  ? Colors.black
                  : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget searchButtonWidget() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search, size: 16),
        filled: true,
        fillColor: AppColors.appBarBack,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
