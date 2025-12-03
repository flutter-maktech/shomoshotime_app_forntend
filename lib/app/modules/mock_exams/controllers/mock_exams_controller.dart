import 'package:get/get.dart';

class MockExamsController extends GetxController {
  var selectIndex=0.obs;
  void changeIndex(int index){
    selectIndex.value=index;
  }
}
