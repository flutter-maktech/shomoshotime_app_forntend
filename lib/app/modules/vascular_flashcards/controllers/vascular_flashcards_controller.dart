import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../all_utils/log.dart';
import '../../../core/user_panel_model/flash_card_set_response.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';

class FlashcardsSetController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt contentId = 0.obs;
  final currentIndex = 0.obs;
  final RxInt totalCards = 0.obs;

  // Pagination variables
  int currentPage = 1;
  int lastPage = 1;

  // Use a list to store all cards from multiple pages
  final allCards = <FlashCardSetItem>[].obs;

  final Rx<FlashCardSetResponse?> flashCardSetResponse =
      Rx<FlashCardSetResponse?>(null);

  late final PageController pageController;
  final showAnswer = false.obs;
  final RxInt select = 0.obs;

  /// Tracks previous page index to detect "next" vs "previous"
  int _previousPageIndex = 0;

  /// Returns list of cards safely
  List<FlashCardSetItem> get cards => allCards;

  @override
  void onInit() {
    super.onInit();

    // Set contentId and totalCards from arguments
    if (Get.arguments != null) {
      if (Get.arguments['contentId'] != null) {
        contentId.value = Get.arguments['contentId'];
      }
      if (Get.arguments['flashCardsCount'] != null) {
        totalCards.value = Get.arguments['flashCardsCount'];
      }
    }

    pageController = PageController();

    // Fetch cards but DO NOT hit API yet
    fetchFlashCardsSet();
  }

  Future<void> fetchFlashCardsSet({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
        allCards.clear();
      } else {
        isLoadingMore.value = true;
      }
      errorMessage.value = '';

      final token = await AppPreference.getToken();
      final requestBody = {
        "content_id": contentId.value,
        "page": page.toString(),
      };

      final response = await _networkCaller.postRequest(
        Urls.flashCardSetList,
        requestBody,
        token: token,
      );

      final newResponse = FlashCardSetResponse.fromJson(response);
      flashCardSetResponse.value = newResponse;

      if (newResponse.success) {
        allCards.addAll(newResponse.data);

        if (newResponse.meta != null) {
          currentPage = newResponse.meta!.currentPage;
          lastPage = newResponse.meta!.lastPage;
          // Only update total if it's 0 (from arguments)
          if (totalCards.value == 0) {
            totalCards.value = newResponse.meta!.total;
          }
        }

        // Restore progress (only on first load)
        if (page == 1 && allCards.isNotEmpty) {
          final savedIndex = await AppPreference.getFlashcardProgress(
            contentId.value,
          );
          if (savedIndex > 0) {
            // If saved index is beyond currently loaded cards, we might need to load more
            // but for now let's just cap it or handle it simply.
            // Usually progress is restored to where the user left off.
            if (savedIndex < allCards.length) {
              currentIndex.value = savedIndex;
              _previousPageIndex = savedIndex;
              Future.delayed(const Duration(milliseconds: 100), () {
                if (pageController.hasClients) {
                  pageController.jumpToPage(savedIndex);
                }
              });
            } else {
              // If savedIndex is further, we might need to fetch all up to that index
              // For simplicity, let's just start at 0 if it's not loaded
              AppLogger.log(
                'Saved index $savedIndex is beyond currently loaded cards',
              );
            }
          }
        }
      }
    } catch (e) {
      errorMessage.value = 'Failed to load flashcards: $e';
      AppLogger.log('Error fetching flashcards: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
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

    // Load more if we're at the last card and there are more pages
    if (index == cards.length - 1 && currentPage < lastPage && !isLoadingMore.value) {
      fetchFlashCardsSet(page: currentPage + 1);
    }
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
