import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../../core/user_panel_model/flash_card_reponse_model.dart';

class FlashCardsController extends GetxController {
  final homeController = Get.find<HomeController>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  List<FlashCardItem> get flashCards => homeController.flashCards;
  var selectIndex = 0.obs;
  void changeIndex(int index) {
    selectIndex.value = index;
  }
}
