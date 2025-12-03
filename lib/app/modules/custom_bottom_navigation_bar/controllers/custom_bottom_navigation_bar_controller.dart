import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/flash_cards/views/flash_cards_view.dart';
import 'package:shomoshotime/app/modules/home/views/home_view.dart';
import 'package:shomoshotime/app/modules/mock_exams/views/mock_exams_view.dart';
import 'package:shomoshotime/app/modules/practice/views/practice_view.dart';
import 'package:shomoshotime/app/modules/study_guides/views/study_guides_view.dart';

class CustomBottomNavigationBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  final pages = [
    HomeView(),
    StudyGuidesView(),
    FlashCardsView(),
    PracticeView(),
    MockExamsView(),
  ];

  void changeIndex(int index){
    currentIndex.value = index;
  }
}
