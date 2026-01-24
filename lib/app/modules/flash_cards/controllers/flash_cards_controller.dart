import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/user_panel_model/flash_card_reponse_model.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../all_utils/app_preference.dart';

class FlashCardsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxInt selectIndex = 0.obs;

  // Pagination variables
  final allFlashCards = <FlashCardItem>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int lastPage = 1;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isRefreshing = false.obs;

  List<FlashCardItem> get flashCards => allFlashCards;

  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    // Initial fetch
    fetchFlashCards();

    // Scroll listener
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage < lastPage && !isLoadingMore.value) {
        fetchFlashCards(page: currentPage + 1);
      }
    }
  }

  Future<void> refreshFlashCards() async {
    isRefreshing.value = true;
    currentPage = 1;
    lastPage = 1;
    allFlashCards.clear();
    await fetchFlashCards(page: 1);
    isRefreshing.value = false;
  }

  Future<void> fetchFlashCards({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final token = await AppPreference.getToken();

      final body = {'page': page.toString()};

      final response = await _networkCaller.postRequest(
        Urls.flashCardList,
        body,
        token: token,
      );

      final flashCardResponse = FlashCardResponse.fromJson(response);

      if (flashCardResponse.success) {
        if (page == 1) {
          allFlashCards.assignAll(flashCardResponse.data);
        } else {
          allFlashCards.addAll(flashCardResponse.data);
        }

        if (flashCardResponse.meta != null) {
          currentPage = flashCardResponse.meta!.currentPage;
          lastPage = flashCardResponse.meta!.lastPage;
        }
      }
    } catch (e) {
      debugPrint('Error fetching flash cards: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
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

  List<FlashCardItem> get filteredFlashCards {
    final categoryFiltered = _filterByCategory();
    return _filterBySearch(categoryFiltered);
  }

  List<FlashCardItem> _filterByCategory() {
    if (selectIndex.value == 0) return flashCards;

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
        return flashCards;
    }

    return flashCards.where((card) {
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

  List<FlashCardItem> _filterBySearch(List<FlashCardItem> list) {
    final query = searchQuery.value.toLowerCase().trim();

    if (query.isEmpty) return list;

    return list.where((card) {
      return card.title.toLowerCase().contains(query) ||
          card.subtitle.toLowerCase().contains(query) ||
          card.category.toLowerCase().contains(query);
    }).toList();
  }
}
