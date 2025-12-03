import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class StudyGuidesController extends GetxController {
  RxInt select=0.obs;
  void  changeValue(int index){
    select.value= index;
  }

  var selectIndex=0.obs;
  void changeIndex(int index){
    selectIndex.value=index;
  }

  final audioPlayer = AudioPlayer();

  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

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
    await audioPlayer.play(UrlSource(url));
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }

  Future<void> seekTo(Duration pos) async {
    await audioPlayer.seek(pos);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
