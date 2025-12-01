import 'package:get/get.dart';

class SpiPracticeBankQusController extends GetxController {
  RxInt selectedIndex = (-1).obs;

  void selectOption(int index) {
    selectedIndex.value = index;
  }
}
