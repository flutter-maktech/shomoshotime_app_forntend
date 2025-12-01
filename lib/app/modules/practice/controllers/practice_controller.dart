import 'package:get/get.dart';

class PracticeController extends GetxController {
  var selectIndex=0.obs;
  void changeIndex(int index){
    selectIndex.value=index;
  }
}
