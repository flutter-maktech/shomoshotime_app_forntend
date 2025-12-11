import 'package:get/get.dart';

class SpiFundamentalsController extends GetxController {

  final page = 0.obs;
  final totalPages = 12.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void nextPage() {
    if (page.value < totalPages.value) {
      page.value++;
    }
  }

  void previousPage() {
    if (page.value > 0) {
      page.value--;
    }
  }
}
