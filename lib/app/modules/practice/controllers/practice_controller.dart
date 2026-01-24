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

  // Pagination variables
  final allQuestionSets = <QuestionSetData>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int lastPage = 1;
  var isLoadingMore = false.obs;
  var isRefreshing = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial fetch
    fetchPracticeData();
    fetchPracticeProgress();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    // Scroll listener
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage < lastPage && !isLoadingMore.value) {
        fetchPracticeData(page: currentPage + 1);
      }
    }
  }

  Future<void> refreshPracticeData() async {
    isRefreshing.value = true;
    currentPage = 1;
    lastPage = 1;
    allQuestionSets.clear();
    await fetchPracticeData(page: 1);
    // Also refresh analytics/progress if needed, though typically separate
    await fetchPracticeProgress();
    isRefreshing.value = false;
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
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
    if (selectIndex.value == 0) return allQuestionSets;

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
        return allQuestionSets;
    }

    return allQuestionSets.where((card) {
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
    // Keep loading separate or shared? usually separate for progress
    // isloading.value = true; // Maybe don't block UI for this if refreshing
    if (allQuestionSets.isEmpty) isloading.value = true;

    errorText.value = '';
    try {
      final body = {
        "studyAnalytics": "true",
        "flashcardAnalytics": "true",
        "practiceAccuracy": "true",
        "mockTestAccuracy": "true",
        "practiceProgress": "true",
        "mockTestProgress": "true",
      };

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
      if (allQuestionSets.isEmpty) isloading.value = false;
    }
  }

  Future<void> fetchPracticeData({int page = 1}) async {
    if (page == 1) {
      isloading.value = true;
    } else {
      isLoadingMore.value = true;
    }
    errorText.value = '';
    try {
      final body = {"current_mode": "practice", "page": page.toString()};

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.praciceQuesionSet,
        body,
        token: token,
      );

      final responseData = QuestionSetResponse.fromJson(response);
      questionSetResponse.value =
          responseData; // Keep mostly for other usages if any

      if (responseData.success) {
        if (page == 1) {
          allQuestionSets.assignAll(responseData.data);
        } else {
          allQuestionSets.addAll(responseData.data);
        }

        currentPage = responseData.meta.currentPage;
        lastPage = responseData.meta.lastPage;
      }
    } catch (e) {
      print('------------------An eeeerror occurred: $e');
      errorText.value = 'An eeeerror occurred: $e';
    } finally {
      isloading.value = false;
      isLoadingMore.value = false;
    }
  }

  // List<QuestionSetData> get questionSets =>
  //     questionSetResponse.value?.data ?? []; // Use allQuestionSets instead

  List<UserAnalyticsData> get userAnalyticsData =>
      userAnalyticsResponse.value != null
      ? [userAnalyticsResponse.value!.data]
      : [];
}
