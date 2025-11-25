import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/primary_app_bar.dart';
import 'package:shomoshotime/app/modules/study_guides/widget/spi_fundamentals_card.dart';

import '../controllers/study_guides_controller.dart';

class StudyGuidesView extends GetView<StudyGuidesController> {
  const StudyGuidesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: PrimaryAppBar()),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      'Study Guides',
                      style: AppTextStyles.medium20.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    Text(
                      'Comprehensive study materials for all specialties',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.appBarSub,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: buildToggleButton(),
                    ),
                    SizedBox(height: 12.h),
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
                  height: 46 .h,
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
            Obx(() {
              if(controller.select.value ==0){
                return  SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: SpiFundamentalsCard(
                        timeText: '9 hours',
                        chapterText: '5/12 Chapters',
                        progressPercentText: '75%',
                        progressValue: 0.75,
                      ),
                    );
                  }, childCount: 4),
                );
              }else{
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Container(
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
                            SizedBox(height: 10.h,),
                            Text('SPI Fundamentals', style: AppTextStyles.bold18),
                            Text(
                              'Master the core principles of ultrasound physics and',
                              style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
                            ),
                            SizedBox(height: 15.h),



                            SizedBox(height: 20.h),
                            CustomButton(childText: 'Continue to listen'),
                          ],
                        ),
                      ),
                    );
                  }, childCount: 4),
                );
              }
            })

          ],
        ),
      ),
    );
  }


  DecoratedBox buildToggleButton() {
    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(170),
                        color: AppColors.appBarBack,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.changeValue(0);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.select.value == 0
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        120,
                                      ),
                                    ),
                                  ),
                                  child: Text('Read'),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.changeValue(1);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        controller.select.value == 1
                                        ? AppColors.primaryColor
                                        : AppColors.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        120,
                                      ),
                                    ),
                                  ),
                                  child: Text('Audio'),
                                ),
                              ),
                            ],
                          ),
                        ),
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


