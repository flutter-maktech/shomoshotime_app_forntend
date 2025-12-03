import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';

import '../../common_widgets/primary_app_bar.dart';
import '../controllers/audio_play_card_controller.dart';

class AudioPlayCardView extends GetView<AudioPlayCardController> {
  const AudioPlayCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar(
                title: 'Study Guides',
                subTitle: 'Comprehensive study materials for all specialties',
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  width: double.infinity,
                  // height: 400,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
                            height: 280,
                            width: double.infinity,
                            child: Image.network(
                              'https://i.pinimg.com/736x/59/78/2e/59782ef2b4973adf395fb28eb3470014.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Slider(
                              min: 0,
                              max: controller.duration.value.inSeconds
                                  .toDouble(),
                              value: controller.position.value.inSeconds
                                  .clamp(0, controller.duration.value.inSeconds)
                                  .toDouble(),
                              activeColor: Colors.orange,
                              inactiveColor: Colors.grey.shade300,
                              onChanged: (value) async {
                                final newPos = Duration(seconds: value.toInt());
                                await controller.seekTo(newPos);
                              },
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.formatTime(
                                    controller.position.value,
                                  ),
                                ),
                                Text(
                                  controller.formatTime(
                                    (controller.duration.value -
                                                controller.position.value)
                                            .isNegative
                                        ? Duration.zero
                                        : controller.duration.value -
                                              controller.position.value,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 1 sec BACK button
                                IconButton(
                                  icon: Icon(Icons.replay_10, size: 30),
                                  onPressed: () async {
                                    final newPos =
                                        controller.position.value -
                                        Duration(seconds: 2);
                                    await controller.seekTo(
                                      newPos.isNegative
                                          ? Duration.zero
                                          : newPos,
                                    );
                                  },
                                ),
                                SizedBox(width: 20),
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.black,
                                  child: IconButton(
                                    icon: Icon(
                                      controller.isPlaying.value
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 45,
                                    ),
                                    onPressed: () async {
                                      if (controller.isPlaying.value) {
                                        await controller.pauseAudio();
                                      } else {
                                        await controller.playAudio(
                                          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
                                        );
                                      }
                                    },
                                  ),
                                ),

                                SizedBox(width: 20),

                                IconButton(
                                  icon: Icon(Icons.forward_10, size: 30),
                                  onPressed: () async {
                                    final newPos =
                                        controller.position.value +
                                        Duration(seconds: 2);

                                    if (newPos < controller.duration.value) {
                                      await controller.seekTo(newPos);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
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
