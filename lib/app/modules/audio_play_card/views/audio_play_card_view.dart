import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../../study_guides/widgets/audio_player_widget.dart';

import '../controllers/audio_play_card_controller.dart';

class AudioPlayCardView extends GetView<AudioPlayCardController> {
  const AudioPlayCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String title = args['title'];
    final String subtitle = args['subtitle'];
    final String audioUrl = args['audioUrl'];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(title: title, subTitle: subtitle),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.infinity,
                  // height: 400,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.appBarBack,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50),
                          child: SizedBox(
                            height: 350,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.progressBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.music_note_rounded,
                                  size: 100.sp,
                                  color: AppColors.primaryGray,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      AudioPlayerWidget(
                        audioUrl: audioUrl,
                        title: title,
                        subtitle: subtitle,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
