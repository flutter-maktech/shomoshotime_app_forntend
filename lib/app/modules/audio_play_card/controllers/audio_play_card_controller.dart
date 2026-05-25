import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/log.dart';

class AudioPlayCardController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  RxBool isPlaying = false.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  RxString currentAudioUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();

    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });

    audioPlayer.durationStream.listen((d) {
      duration.value = d ?? Duration.zero;
    });

    audioPlayer.positionStream.listen((p) {
      position.value = p;
      // Save progress every 5 seconds
      if (p.inSeconds > 0 &&
          p.inSeconds % 5 == 0 &&
          currentAudioUrl.value.isNotEmpty) {
        AppPreference.saveAudioProgress(currentAudioUrl.value, p.inSeconds);
      }
    });

    audioPlayer.setLoopMode(LoopMode.one);
  }

  Future<void> playAudio(String url, {String? title, String? subtitle}) async {
    AppLogger.log('AudioPlayCard: Streaming from fileUrl = $url');
    currentAudioUrl.value = url;

    try {
      // Restore progress
      final savedSeconds = await AppPreference.getAudioProgress(url);
      if (savedSeconds > 0) {
        position.value = Duration(seconds: savedSeconds);
        AppLogger.log('Restored audio progress: $savedSeconds seconds');
      }

      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: url,
            album: "Study Guides",
            title: title ?? "Study Guide Audio",
            artist: subtitle ?? "Sonographer Pal",
          ),
        ),
        initialPosition: position.value,
      );

      await audioPlayer.play();
    } catch (e) {
      AppLogger.log('Audio play error: $e');
    }
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    if (currentAudioUrl.value.isNotEmpty) {
      await AppPreference.saveAudioProgress(
        currentAudioUrl.value,
        position.value.inSeconds,
      );
    }
  }

  Future<void> resumeAudio() async => audioPlayer.play();

  Future<void> seekTo(Duration pos) async => audioPlayer.seek(pos);

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes % 60)}:${twoDigits(duration.inSeconds % 60)}';
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
