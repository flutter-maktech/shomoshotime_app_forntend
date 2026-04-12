import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../all_utils/app_preference.dart';
import '../../../all_utils/log.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/user_panel_model/flash_card_reponse_model.dart';
import '../../home/controllers/home_controller.dart';

class FlashCardsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxInt selectIndex = 0.obs;
  final RxString selectedCategory = 'All'.obs;

  Future<void> filterFlashCards(String categoryName, int index) async {
    changeIndex(index);
    selectedCategory.value = categoryName;
    await refreshFlashCards();
  }

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

    // Check if HomeController has already fetched the first page of flash cards
    bool dataInitialized = false;
    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      final homeData = homeController.flashCardResponse.value;
      if (homeData != null && homeData.data.isNotEmpty) {
        allFlashCards.assignAll(homeData.data);
        if (homeData.meta != null) {
          currentPage = homeData.meta!.currentPage;
          lastPage = homeData.meta!.lastPage;
        }
        dataInitialized = true;
        AppLogger.log(
          'FlashCardsController: Initialized from HomeController data',
        );
      }
    }

    // Initial fetch only if not initialized from HomeController
    if (!dataInitialized) {
      fetchFlashCards();
    }

    // Scroll listener
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    for (final position in scrollController.positions) {
      if (position.pixels >= position.maxScrollExtent) {
        if (currentPage < lastPage && !isLoadingMore.value) {
          fetchFlashCards(page: currentPage + 1);
          break; // Trigger once
        }
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

      final body = <String, dynamic>{'page': page.toString()};
      if (selectedCategory.value != 'All') {
        body['category'] = selectedCategory.value;
      }

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
      AppLogger.log('Error fetching flash cards: $e');
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
    return _filterBySearch(flashCards);
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
