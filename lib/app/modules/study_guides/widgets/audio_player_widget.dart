// audio_player_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/study_guides_controller.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudyGuidesController>();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            min: 0,
            max: controller.duration.value.inSeconds.toDouble(),
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
                controller.formatTime(controller.position.value),
                style: AppTextStyles.regular12.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
              Text(
                controller.formatTime(
                  (controller.duration.value - controller.position.value)
                          .isNegative
                      ? Duration.zero
                      : controller.duration.value - controller.position.value,
                ),
                style: AppTextStyles.regular12.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rewind 2 seconds
              IconButton(
                icon: Icon(Icons.replay_10, size: 30),
                onPressed: () async {
                  final newPos =
                      controller.position.value - Duration(seconds: 2);
                  await controller.seekTo(
                    newPos.isNegative ? Duration.zero : newPos,
                  );
                },
              ),

              SizedBox(width: 20),

              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
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

              // Forward 2 seconds
              IconButton(
                icon: Icon(Icons.forward_10, size: 30),
                onPressed: () async {
                  final newPos =
                      controller.position.value + Duration(seconds: 2);
                  if (newPos < controller.duration.value) {
                    await controller.seekTo(newPos);
                  }
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
