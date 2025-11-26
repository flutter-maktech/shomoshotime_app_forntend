import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/views/home_view.dart';

class CustomBottomNavigationBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  final pages = [
    HomeView(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  void changeIndex(int index){
    currentIndex.value = index;
  }
}
