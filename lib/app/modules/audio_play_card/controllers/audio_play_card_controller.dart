import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shomoshotime/app/all_utils/log.dart';

class AudioPlayCardController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  RxBool isPlaying = false.obs;
  Rx<Duration> duration = Duration.zero.obs;
  Rx<Duration> position = Duration.zero.obs;

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
    });

    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> playAudio(String url) async {
    AppLogger.log('AudioPlayCard: Streaming from fileUrl = $url');
    await audioPlayer.play(UrlSource(url));
  }

  Future<void> pauseAudio() async => audioPlayer.pause();

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
