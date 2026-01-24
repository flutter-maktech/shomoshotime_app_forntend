import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/core/urls/urls.dart' show Urls;
import 'package:shomoshotime/app/core/user_panel_model/user_analytics_response.dart';
import 'package:shomoshotime/app/modules/practice/controllers/practice_controller.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/user_panel_model/question_set_response.dart';

class MockExamsController extends GetxController {
  final practiceController = Get.find<PracticeController>();
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
  List<QuestionSetData> get questionSets => allMockTests; // Use paginated list

  List<UserAnalyticsData> get mockTestAnalytics =>
      practiceController.userAnalyticsData;

  Future<void> fetchMockTestData({int page = 1}) async {
    if (page == 1) {
      isloading.value = true;
    } else {
      isLoadingMore.value = true;
    }
    errorText.value = '';
    try {
      final body = {"current_mode": "mock_test", "page": page.toString()};

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
      print('------$e');
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
    } catch (e) {
      errorText.value = 'An eeeerror occurred: $e';
      print('----------------$e');
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
}
