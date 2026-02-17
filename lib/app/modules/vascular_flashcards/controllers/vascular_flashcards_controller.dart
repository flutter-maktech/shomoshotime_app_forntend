import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/log.dart';
import 'package:shomoshotime/app/core/user_panel_model/flash_card_set_response.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';

class FlashcardsSetController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt contentId = 0.obs;
  final currentIndex = 0.obs;
  final Rx<FlashCardSetResponse?> flashCardSetResponse =
      Rx<FlashCardSetResponse?>(null);

  late final PageController pageController;
  final showAnswer = false.obs;
  final RxInt select = 0.obs;

  /// Tracks previous page index to detect "next" vs "previous"
  int _previousPageIndex = 0;

  /// Returns list of cards safely
  List<FlashCardSetItem> get cards => flashCardSetResponse.value?.data ?? [];

  @override
  void onInit() {
    super.onInit();

    // Set contentId from arguments
    if (Get.arguments != null && Get.arguments['contentId'] != null) {
      contentId.value = Get.arguments['contentId'];
    }

    pageController = PageController();

    // Fetch cards but DO NOT hit API yet
    fetchFlashCardsSet();
  }

  Future<void> fetchFlashCardsSet() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();
      final requestBody = {"content_id": contentId.value};

      final response = await _networkCaller.postRequest(
        Urls.flashCardSetList,
        requestBody,
        token: token,
      );

      flashCardSetResponse.value = FlashCardSetResponse.fromJson(response);

      // Restore progress
      if (flashCardSetResponse.value != null &&
          flashCardSetResponse.value!.data.isNotEmpty) {
        final savedIndex = await AppPreference.getFlashcardProgress(
          contentId.value,
        );
        if (savedIndex > 0 &&
            savedIndex < flashCardSetResponse.value!.data.length) {
          currentIndex.value = savedIndex;
          _previousPageIndex = savedIndex;
          // Use jumpToPage instead of animateToPage during init to avoid visual scroll
          Future.delayed(const Duration(milliseconds: 100), () {
            if (pageController.hasClients) {
              pageController.jumpToPage(savedIndex);
            }
          });
          AppLogger.log('Restored flashcard progress: index $savedIndex');
        }
      }
    } catch (e) {
      errorMessage.value = 'Failed to load flashcards: $e';
      AppLogger.log('Error fetching flashcards: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Hit next flash card API
  Future<void> hitNextFlashCardApi(int cardId) async {
    try {
      final token = await AppPreference.getToken();

      final body = {"content_id": contentId.value, "card_id": cardId};

      await _networkCaller.postRequest(Urls.nextFlashCard, body, token: token);
    } catch (e) {
      AppLogger.log('Next flash card API error: $e');
    }
  }

  /// Page change handler
  void onPageChanged(int index) {
    if (cards.isEmpty || index >= cards.length) return;

    // Reset show answer when page changes
    showAnswer.value = false;

    // Update previous index for next button logic
    _previousPageIndex = index;
    currentIndex.value = index;

    // Save progress
    AppPreference.saveFlashcardProgress(contentId.value, index);
  }

  /// Set index programmatically (Back/Next buttons)
  void setIndex(int index) {
    if (cards.isEmpty || index >= cards.length || index < 0) return;

    _previousPageIndex = index;
    currentIndex.value = index;
    showAnswer.value = false;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Show answer for current card
  /// ⚡ API is triggered only when user clicks "Show Answer"
  void showAnswerText() {
    if (cards.isEmpty) return;

    showAnswer.value = true;

    // Only hit API if user moves forward
    if (currentIndex.value >= _previousPageIndex) {
      final cardId = cards[currentIndex.value].id;
      hitNextFlashCardApi(cardId);
    }

    // Update previous page index
    _previousPageIndex = currentIndex.value;
  }

  /// Change button selection
  void changeButton(int index) {
    select.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
