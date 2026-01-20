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
                onPressed: isThisAudioPlaying
                    ? () async {
                        final newPos =
                            controller.position.value - Duration(seconds: 10);
                        await controller.seekTo(
                          newPos.isNegative ? Duration.zero : newPos,
                        );
                      }
                    : null,
              ),
              SizedBox(width: 20),
              
              // Play/Pause button
              Obx(() {
                final isLoadingThisAudio = 
                    controller.isLoading.value && 
                    controller.currentAudioUrl.value == audioUrl;
                
                return CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: isLoadingThisAudio
                      ? SizedBox(
                          width: 45,
                          height: 45,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        )
                      : IconButton(
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
                        ),
                );
              }),

              SizedBox(width: 20),

              IconButton(
                icon: Icon(Icons.forward_10, size: 30),
                onPressed: isThisAudioPlaying
                    ? () async {
                        final newPos =
                            controller.position.value + Duration(seconds: 10);

                        if (newPos < controller.duration.value) {
                          await controller.seekTo(newPos);
                        }
                      }
                    : null,
              ),
            ],
          ),
          
          // Buffering indicator (for streaming)
          if (isThisAudioPlaying && controller.position.value.inSeconds > 0 && 
              controller.duration.value.inSeconds > 0 &&
              controller.position.value.inSeconds >= controller.duration.value.inSeconds - 1)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Buffering...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }
}