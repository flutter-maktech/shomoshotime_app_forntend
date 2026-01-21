// audio_player_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/study_guides_controller.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key, required this.audioUrl});

  final String audioUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudyGuidesController>();
    return Obx(() {
      final isThisAudioPlaying =
          controller.currentAudioUrl.value == audioUrl &&
          controller.isPlaying.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Slider(
            min: 0,
            max: isThisAudioPlaying
                ? controller.duration.value.inSeconds.toDouble()
                : 1,
            activeColor: Colors.orange,
            inactiveColor: Colors.grey.shade300,
            value: isThisAudioPlaying
                ? controller.position.value.inSeconds
                      .clamp(0, controller.duration.value.inSeconds)
                      .toDouble()
                : 0,
            onChanged: isThisAudioPlaying
                ? (value) async {
                    await controller.seekTo(Duration(seconds: value.toInt()));
                  }
                : null,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isThisAudioPlaying
                    ? controller.formatTime(controller.position.value)
                    : '00:00',
              ),

              Text(
                isThisAudioPlaying
                    ? controller.formatTime(
                        controller.duration.value - controller.position.value,
                      )
                    : '00:00',
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
                      controller.position.value - Duration(seconds: 10);
                  await controller.seekTo(
                    newPos.isNegative ? Duration.zero : newPos,
                  );
                },
              ),
              SizedBox(width: 20),
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.black,
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.currentAudioUrl.value == audioUrl) {
                    // Show loading indicator if this audio is downloading
                    return SizedBox(
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 4,
                      ),
                    );
                  }

                  // Otherwise show play/pause icon
                  final isThisAudioPlaying =
                      controller.currentAudioUrl.value == audioUrl &&
                      controller.isPlaying.value;

                  return IconButton(
                    icon: Icon(
                      isThisAudioPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 45,
                    ),
                    onPressed: () async {
                      if (isThisAudioPlaying) {
                        await controller.pauseAudio();
                      } else {
                        await controller.playAudio(audioUrl);
                      }
                    },
                  );
                }),
              ),

              SizedBox(width: 20),

              IconButton(
                icon: Icon(Icons.forward_10, size: 30),
                onPressed: () async {
                  final newPos =
                      controller.position.value + Duration(seconds: 10);

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
