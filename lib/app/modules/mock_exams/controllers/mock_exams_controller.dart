import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../all_utils/log.dart';
import '../../../core/urls/urls.dart' show Urls;
import '../../../core/user_panel_model/user_analytics_response.dart';
import '../../home/controllers/home_controller.dart';
import '../../practice/controllers/practice_controller.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/user_panel_model/question_set_response.dart';

class MockExamsController extends GetxController {
  final practiceController = Get.find<PracticeController>();
  final _homeController = Get.find<HomeController>();
  RxBool isloading = false.obs;
  RxString errorText = ''.obs;

  // Pagination variables
  final allMockTests = <QuestionSetData>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int lastPage = 1;
  var isLoadingMore = false.obs;
  var isRefreshing = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMockTestData();
    // Scroll listener
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    for (final position in scrollController.positions) {
      if (position.pixels >= position.maxScrollExtent) {
        if (currentPage < lastPage && !isLoadingMore.value) {
          fetchMockTestData(page: currentPage + 1);
          break; // Trigger once
        }
      }
    }
  }

  Future<void> refreshMockTestData() async {
    isRefreshing.value = true;
    currentPage = 1;
    lastPage = 1;
    allMockTests.clear();
    await fetchMockTestData(page: 1);
    isRefreshing.value = false;
  }

  NetworkCaller networkCaller = NetworkCaller();
  final Rx<QuestionSetResponse?> questionSetResponse = Rx<QuestionSetResponse?>(
    null,
  );
  List<QuestionSetData> get questionSets => filteredMockTests; 

    List<QuestionSetData> get filteredMockTests {
    if (selectIndex.value == 0) {
      return allMockTests.where((card) {
        final title = card.title.toLowerCase();
        final subtitle = card.subtitle.toLowerCase();
        final category = card.category.toLowerCase();
        return title.contains('arrt') ||
            subtitle.contains('arrt') ||
            category.contains('arrt');
      }).toList();
    }

    final String selectedCategory;
    switch (selectIndex.value) {
      case 1:
        selectedCategory = 'SPI';
        break;
      case 2:
        selectedCategory = 'Vascular';
        break;
      case 3:
        selectedCategory = 'OB/GYN';
        break;
      case 4:
        selectedCategory = 'Abdomen';
        break;
      default:
        return [];
    }

    final filtered = allMockTests.where((card) {
      final cardCategory = card.category.toLowerCase().trim();
      final filterCategory = selectedCategory.toLowerCase().trim();

      final title = card.title.toLowerCase();
      final subtitle = card.subtitle.toLowerCase();
      if (title.contains('arrt') || subtitle.contains('arrt')) {
        return false;
      }

      if (cardCategory.contains(filterCategory) ||
          filterCategory.contains(cardCategory)) {
        return true;
      }

      if (selectedCategory == 'SPI' &&
          (cardCategory.contains('spi') ||
              cardCategory.contains('sonography'))) {
        return true;
      }

      if (selectedCategory == 'OB/GYN' &&
          (cardCategory.contains('ob') || cardCategory.contains('gyn'))) {
        return true;
      }

      return false;
    }).toList();

    if (selectedCategory == 'Vascular') {
      return _sortOnlyArdmsRvtMockExams(filtered);
    }

    return filtered;
  }

  List<UserAnalyticsData> get mockTestAnalytics =>
      _homeController.userAnalyticsData;

  Future<void> fetchMockTestData({int page = 1}) async {
    if (page == 1) {
      isloading.value = true;
    } else {
      isLoadingMore.value = true;
    }
    errorText.value = '';
    try {
      final body = {
        "current_mode": "mock_test",
        "type": "1",
        "page": page.toString(),
        "per_page": "100",
      };

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.praciceQuesionSet,
        body,
        token: token,
      );

      final responseData = QuestionSetResponse.fromJson(response);
      questionSetResponse.value = responseData;

      if (responseData.success) {
        if (page == 1) {
          allMockTests.assignAll(responseData.data);
        } else {
          allMockTests.addAll(responseData.data);
        }

        currentPage = responseData.meta.currentPage;
        lastPage = responseData.meta.lastPage;
      }
    } catch (e) {
      AppLogger.log('------$e');
      errorText.value = 'An eeeerror occurred: $e';
    } finally {
      isloading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> startMockTest(int id) async {
    isloading.value = true;
    errorText.value = '';
    try {
      final body = {"question_set_id": id};

      final token = await AppPreference.getToken();

      await networkCaller.postRequest(Urls.startMockTest, body, token: token);
      await AppPreference.saveQuestionProgress(id, 0);
    } catch (e) {
      errorText.value = 'An eeeerror occurred: $e';
      AppLogger.log('----------------$e');
    } finally {
      isloading.value = false;
    }
  }

  var selectIndex = 0.obs;
  void changeIndex(int index) {
    selectIndex.value = index;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
    bool _isArdmsRvtMockExam(QuestionSetData card) {
    final normalizedTitle = card.title.trim().toLowerCase();
    return RegExp(r'^\d+\.\s*ardms rvt mock exam$').hasMatch(normalizedTitle);
  }

  int _extractExamNumber(String title) {
    final match = RegExp(r'^\s*(\d+)\.').firstMatch(title);
    return int.tryParse(match?.group(1) ?? '') ?? 999999;
  }

  List<QuestionSetData> _sortOnlyArdmsRvtMockExams(
    List<QuestionSetData> items,
  ) {
    final result = List<QuestionSetData>.from(items);

    final rvtIndices = <int>[];
    final rvtItems = <QuestionSetData>[];

    for (int i = 0; i < items.length; i++) {
      if (_isArdmsRvtMockExam(items[i])) {
        rvtIndices.add(i);
        rvtItems.add(items[i]);
      }
    }

    rvtItems.sort(
      (a, b) => _extractExamNumber(a.title).compareTo(
        _extractExamNumber(b.title),
      ),
    );

    for (int i = 0; i < rvtIndices.length; i++) {
      result[rvtIndices[i]] = rvtItems[i];
    }

    return result;
  }
}
