import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/core/urls/urls.dart';
import 'package:shomoshotime/app/core/user_panel_model/question_set_response.dart';
import 'package:shomoshotime/app/core/user_panel_model/user_analytics_response.dart';

class PracticeController extends GetxController {
  RxBool isloading = false.obs;
  RxString errorText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxInt selectIndex = 0.obs;

  NetworkCaller networkCaller = NetworkCaller();
  final Rx<QuestionSetResponse?> questionSetResponse = Rx<QuestionSetResponse?>(
    null,
  );
  final Rx<UserAnalyticsResponse?> userAnalyticsResponse =
      Rx<UserAnalyticsResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchPracticeData();
    fetchPracticeProgress();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void changeIndex(int index) {
    selectIndex.value = index;
  }

  List<QuestionSetData> get filteredQuestionSets {
    final categoryFiltered = _filterByCategory();
    return _filterBySearch(categoryFiltered);
  }

  List<QuestionSetData> _filterByCategory() {
    if (selectIndex.value == 0) return questionSets;

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
        return questionSets;
    }

    return questionSets.where((card) {
      final cardCategory = card.category.toLowerCase().trim();
      final filterCategory = selectedCategory.toLowerCase().trim();

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
  }

  List<QuestionSetData> _filterBySearch(List<QuestionSetData> list) {
    final query = searchQuery.value.toLowerCase().trim();

    if (query.isEmpty) return list;

    return list.where((question) {
      return question.title.toLowerCase().contains(query) ||
          question.subtitle.toLowerCase().contains(query) ||
          question.category.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> fetchPracticeProgress() async {
    isloading.value = true;
    errorText.value = '';
    try {
      final body = {"practiceAccuracy": "true", "practiceProgress": "true"};

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.userAnalytics,
        body,
        token: token,
      );
      userAnalyticsResponse.value = UserAnalyticsResponse.fromJson(response);
    } catch (e) {
      errorText.value = 'An errorrrr occurred: $e';
    } finally {
      isloading.value = false;
    }
  }

  Future<void> fetchPracticeData() async {
    isloading.value = true;
    errorText.value = '';
    try {
      final body = {"current_mode": "practice"};

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.praciceQuesionSet,
        body,
        token: token,
      );
      questionSetResponse.value = QuestionSetResponse.fromJson(response);
    } catch (e) {
      print('------------------An eeeerror occurred: $e');
      errorText.value = 'An eeeerror occurred: $e';
    } finally {
      isloading.value = false;
    }
  }

  List<QuestionSetData> get questionSets =>
      questionSetResponse.value?.data ?? [];

  List<UserAnalyticsData> get userAnalyticsData =>
      userAnalyticsResponse.value != null
      ? [userAnalyticsResponse.value!.data]
      : [];
}
