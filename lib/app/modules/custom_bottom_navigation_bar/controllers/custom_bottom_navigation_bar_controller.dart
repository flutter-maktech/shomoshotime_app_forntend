import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';

import '../../flash_cards/views/flash_cards_view.dart';
import '../../home/views/home_view.dart';
import '../../mock_exams/views/mock_exams_view.dart';
import '../../practice/views/practice_view.dart';
import '../../study_guides/views/study_guides_view.dart';

class CustomBottomNavigationBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final imageUrl = await AppPreference.getProfileImage();
    if (imageUrl != null) {
      profileImageUrl.value = imageUrl;
    }
  }

  void updateProfileImage(String url) {
    profileImageUrl.value = url;
  }

  // Lazy-loaded screens map
  final Map<int, Widget> _pagesCache = {};

  Widget getCurrentPage() {
    if (!_pagesCache.containsKey(currentIndex.value)) {
      _pagesCache[currentIndex.value] = _buildPage(currentIndex.value);
    }
    return _pagesCache[currentIndex.value]!;
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return StudyGuidesView();
      case 2:
        return FlashCardsView();
      case 3:
        return PracticeView();
      case 4:
        return MockExamsView();
      default:
        return HomeView();
    }
  }
}
