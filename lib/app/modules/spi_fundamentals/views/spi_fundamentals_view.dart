import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';

import '../controllers/spi_fundamentals_controller.dart';

class SpiFundamentalsView extends GetView<SpiFundamentalsController> {
  const SpiFundamentalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CustomAppBar(title: 'SPI Fundamentals')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(color: AppColors.appBarBack),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                        style: AppTextStyles.bold12,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.",
                      ),
                      const SizedBox(height: 10),
                      Align(
                        child: Text('Page-5', style: AppTextStyles.regular10),
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          SliverToBoxAdapter(
            child: Center(
              child: Text('5 / 12 Page', style: AppTextStyles.regular12),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      childText: 'Back',
                      buttonColor: AppColors.lightYellow,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButton(
                      childText: 'Next',
                      buttonColor: AppColors.lightYellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(childText: 'Download'),
            ),
          ),
        ],
      ),
    );
  }
}
