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
}
