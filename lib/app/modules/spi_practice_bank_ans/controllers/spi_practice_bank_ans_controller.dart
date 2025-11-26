import 'package:get/get.dart';

class SpiPracticeBankAnsController extends GetxController {
  RxInt selectedIndex = (-1).obs;

  void selectOption(int index) {
    selectedIndex.value = index;
  }
}
