/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VascularFlashcardsController extends GetxController {
  final currentIndex = 0.obs;
  final int totalDots = 6;
 RxInt select=0.obs;
  void changeButton(int index){
    select.value =index;
  }

  // sob page-e ei ekoi text use hobe
  final String questionText =
      'What impact does frequency have on image quality and depth in ultrasound?';

  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void setIndex(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VascularFlashcardsController extends GetxController {
  final currentIndex = 0.obs;
  final int totalDots = 6;

  // Back/Next button select
  RxInt select = 0.obs;
  void changeButton(int index) {
    select.value = index;
  }
  final String questionText =
      'What impact does frequency have on image quality and depth in ultrasound?';

  final String answerText =
      'Higher frequency provides better image resolution but less depth penetration, '
      'while lower frequency penetrates deeper but with lower image resolution.';

  final showAnswer = false.obs;

  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
    showAnswer.value = false; // page change hole answer abar lukiye dibe
  }

  void setIndex(int index) {
    currentIndex.value = index;
    showAnswer.value = false; // dot diye change করলেও answer reset
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void showAnswerText() {
    showAnswer.value = true;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
