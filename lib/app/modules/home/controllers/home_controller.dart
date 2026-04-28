import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../all_utils/app_preference.dart';
import '../../../core/user_panel_model/flash_card_reponse_model.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/user_panel_model/study_guide_response_model.dart';
import '../../../core/user_panel_model/user_analytics_response.dart';

class HomeController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  // Rx variables for state management
  final Rx<StudyGuideResponse?> studyGuideResponse = Rx<StudyGuideResponse?>(
    null,
  );
  final Rx<FlashCardResponse?> flashCardResponse = Rx<FlashCardResponse?>(null);
  final Rx<UserAnalyticsResponse?> userAnalyticsResponse =
      Rx<UserAnalyticsResponse?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString userName = 'User'.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadUserName();
    fetchStudyGuides();
    fetchFlashCards();
    fetchUserAnalytics();
  }

  Future<void> loadUserName() async {
    final name = await AppPreference.getName();
    if (name != null && name.isNotEmpty) {
      userName.value = name;
    }
  }

  // Fetch study guides using POST request
  Future<void> fetchStudyGuides() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();

      // Use POST request with empty body since API only supports POST
      final response = await _networkCaller.postRequest(
        Urls.studyGuideList,
        {}, // Empty body
        token: token,
      );

      // Parse the response
      studyGuideResponse.value = StudyGuideResponse.fromJson(response);
    } catch (e) {
      errorMessage.value = 'Failed to load study guides: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Get study guides list (convenience getter)
  List<StudyGuide> get studyGuides => studyGuideResponse.value?.data ?? [];

  // Refresh data
  Future<void> refreshData() async {
    await Future.wait([
      fetchStudyGuides(),
      fetchFlashCards(),
      fetchUserAnalytics(),
    ]);
  }

  Future<void> fetchFlashCards() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();

      // Use POST request with empty body since API only supports POST
      final response = await _networkCaller.postRequest(
        Urls.flashCardList,
        {}, // Empty body
        token: token,
      );

      // Parse the response
      flashCardResponse.value = FlashCardResponse.fromJson(response);
    } catch (e) {
      errorMessage.value = 'Failed to load flash cards: $e';
    } finally {
      isLoading.value = false;
    }
  }

  List<FlashCardItem> get flashCards => flashCardResponse.value?.data ?? [];

  Future<void> fetchUserAnalytics() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final body = {
        "studyAnalytics": "true",
        "flashcardAnalytics": "true",
        "practiceAccuracy": "true",
        "mockTestAccuracy": "true",
        "practiceProgress": "true",
        "mockTestProgress": "true",
      };

      final token = await AppPreference.getToken();

      final response = await _networkCaller.postRequest(
        Urls.userAnalytics,
        body,
        token: token,
      );
      userAnalyticsResponse.value = UserAnalyticsResponse.fromJson(response);
    } catch (e) {
      errorMessage.value = 'Failed to load user analytics: $e';
    } finally {
      isLoading.value = false;
    }
  }

  List<UserAnalyticsData> get userAnalyticsData =>
      userAnalyticsResponse.value != null
      ? [userAnalyticsResponse.value!.data]
      : [];

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
