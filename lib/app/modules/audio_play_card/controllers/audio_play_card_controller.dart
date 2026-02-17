import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/all_utils/log.dart';

class AudioPlayCardController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  RxBool isPlaying = false.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;
  RxString currentAudioUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    audioPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });

    audioPlayer.onPositionChanged.listen((p) {
      position.value = p;
      // Save progress every 5 seconds
      if (p.inSeconds > 0 &&
          p.inSeconds % 5 == 0 &&
          currentAudioUrl.value.isNotEmpty) {
        AppPreference.saveAudioProgress(currentAudioUrl.value, p.inSeconds);
      }
    });

    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> playAudio(String url) async {
    AppLogger.log('AudioPlayCard: Streaming from fileUrl = $url');
    currentAudioUrl.value = url;

    // Restore progress
    final savedSeconds = await AppPreference.getAudioProgress(url);
    if (savedSeconds > 0) {
      position.value = Duration(seconds: savedSeconds);
      await audioPlayer.play(UrlSource(url));
      await audioPlayer.seek(position.value);
      AppLogger.log('Restored audio progress: $savedSeconds seconds');
    } else {
      await audioPlayer.play(UrlSource(url));
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

  Future<void> resumeAudio() async => audioPlayer.resume();

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
