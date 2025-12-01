import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/primary_app_bar.dart';

import '../controllers/practice_controller.dart';

class PracticeView extends GetView<PracticeController> {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: PrimaryAppBar()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Practice Questions',
                      style: AppTextStyles.medium20.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    Text(
                      'Test your knowledge with thousands of practice questions',
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
          /*  SliverToBoxAdapter(
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.homeStack,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  child:SizedBox(
                    width: double.infinity,
                    height: 340,
                    child: Column(
                      children: [
                        SizedBox(height: 14.h,),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:16,),
                              child: Row(
                                                        children: [
                              Expanded(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                ),child: SizedBox.expand(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:16,vertical: 16,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Row(
                                          children: [
                                            Text("Questions\nAttempted",style: AppTextStyles.regular12.copyWith(color: AppColors.blackColor),),
                                            Spacer(),
                                            Image.asset(ImagePath.frameImage,scale: 5,)
                                          ],
                                        ),
                                       Spacer(),
                                        Text('12 days',style: AppTextStyles.bold24.copyWith(color: AppColors.greyBlack),),
                                        Spacer(),
                                        Row(
                                          children: [
                                           Image.asset(ImagePath.frame21Image,scale: 6,),
                                            SizedBox(width: 4.w,),
                                            Text('+52 this week',style: AppTextStyles.regular12.copyWith(color: AppColors.blackColor)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),),
                              ),
                              SizedBox(width: 14,),
                              Expanded(
                                child: DecoratedBox(decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),child: SizedBox.expand(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:16,vertical: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Row(
                                        children: [
                                          Text("Overall\nAccuracy",style: AppTextStyles.regular12.copyWith(color: AppColors.blackColor),),
                                          Spacer(),
                                          Image.asset(ImagePath.frameImage,scale: 5,)
                                        ],
                                      ),
                                      Spacer(),
                                      Text('810%',style: AppTextStyles.bold24.copyWith(color: AppColors.greyBlack),),
                                        Spacer(),
                                        Text("Above average performance",style: AppTextStyles.regular12.copyWith(color: AppColors.blackColor),),
                                    ],),
                                  ),
                                ),),
                              )
                                                        ],
                                                      ),
                            )),
                        Expanded(child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal:16,vertical: 14),
                          child: DecoratedBox(decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Overall\nAccuracy'),
                                        Spacer(),
                                        Image.asset(
                                          ImagePath.frame21Image, scale: 4,
                                          fit: BoxFit.cover,)
                                      ],
                                    ),
                                    Spacer(),
                                    Text('12 days',style: AppTextStyles.bold24.copyWith(color: AppColors.greyBlack),),
                                    Spacer(),
                                    Text('Above average performance')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                        

                      ],
                    ),
                  ) ,
                ),
              ) ,
            ),*/

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.homeStack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,  // IMPORTANT
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Questions\nAttempted",
                                            style: AppTextStyles.regular12.copyWith(
                                                color: AppColors.blackColor),
                                          ),
                                          Spacer(),
                                          Image.asset(ImagePath.frameImage, scale: 5),
                                        ],
                                      ),

                                    SizedBox(height: 14),
                                      Text(
                                        '430',
                                        style: AppTextStyles.bold24.copyWith(
                                            color: AppColors.greyBlack),
                                      ),
                                      SizedBox(height: 14),

                                      Row(
                                        children: [
                                          Image.asset(ImagePath.frame21Image, scale: 6),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              '+52 this week',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.regular12
                                                  .copyWith(color: AppColors.blackColor,),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(width: 14),


                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Overall\nAccuracy",
                                            style: AppTextStyles.regular12.copyWith(
                                                color: AppColors.blackColor),
                                          ),
                                          Spacer(),
                                          Image.asset(ImagePath.frameImage, scale: 5),
                                        ],
                                      ),
                                      SizedBox(height: 6),

                                      Text(
                                        '810%',
                                        style: AppTextStyles.bold24.copyWith(
                                            color: AppColors.greyBlack),
                                      ),
                                      SizedBox(height: 6),

                                      Text(
                                        "Above average performance",
                                        style: AppTextStyles.regular12
                                            .copyWith(color: AppColors.blackColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        SizedBox(height: 13),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Overall\nAccuracy'),
                                    Spacer(),
                                    Image.asset(ImagePath.frame21Image, scale: 4),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '12 days',
                                  style: AppTextStyles.bold24
                                      .copyWith(color: AppColors.greyBlack),
                                ),
                                SizedBox(height: 10),
                                Text('Above average performance')
                              ],
                            ),
                          ),
                        ),
                      ],
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
                  child: Image.asset(ImagePath.frameImage, scale: 4),
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
            'Comprehensive physics and instrumentation questions',
            style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    'Questions',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '80',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Text(
                    'attempt',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '95',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'Accuracy',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '85%',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Text(
                    'Difficulty',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    'mixed',
                    style: AppTextStyles.regular14.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h,),
          CustomButton(childText: 'Continue Reading'),
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
