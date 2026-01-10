// study_guides_view.dart (refactored)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/category_filter_bar.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../../common_widgets/header_section.dart';
import '../../common_widgets/primary_app_bar.dart';
import '../controllers/study_guides_controller.dart';
import '../widgets/spi_audio_card_list.dart';
import '../widgets/spi_card_list.dart';

class StudyGuidesView extends GetView<StudyGuidesController> {
  const StudyGuidesView({super.key});

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
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(),
                    SizedBox(height: 12.h),
                    CustomTextFormField(),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: CategoryFilterBar(),
              ),
            ),

            // Content section
            Obx(() {
              if (controller.select.value == 0) {
                return SpiCardList();
              } else {
                return SpiAudioCardList();
              }
            }),
          ],
        ),
      ),
    );
  }
}
