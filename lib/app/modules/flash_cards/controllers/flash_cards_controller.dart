import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../../core/user_panel_model/flash_card_reponse_model.dart';

class FlashCardsController extends GetxController {
  final homeController = Get.find<HomeController>();
  TextEditingController searchController = TextEditingController();
  RxBool isSearchQueryNotEmpty = false.obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  List<FlashCardItem> get flashCards => homeController.flashCards;
  var selectIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to search changes
    searchController.addListener(() {
      isSearchQueryNotEmpty.value = searchController.text.isNotEmpty;
      update();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    // Trigger UI update when search text changes
    update();
  }

  void clearSearch() {
    searchController.clear();
    isSearchQueryNotEmpty.value = false;
  }

  // Combined filter for both category and search
  List<FlashCardItem> get filteredFlashCards {
    // First filter by category
    List<FlashCardItem> categoryFiltered = _filterByCategory();

    // Then filter by search if needed
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

      // Flexible matching
      if (cardCategory.contains(filterCategory) ||
          filterCategory.contains(cardCategory)) {
        return true;
      }

      // Handle common variations
      if (selectedCategory == 'SPI' &&
          (cardCategory.contains('spi') || cardCategory == 'sonography')) {
        return true;
      }
      if (selectedCategory == 'OB/GYN' &&
          (cardCategory.contains('ob') || cardCategory.contains('gyn'))) {
        return true;
      }

      return false;
    }).toList();
  }

  List<FlashCardItem> _filterBySearch(List<FlashCardItem> categoryFiltered) {
    final searchText = searchController.text.toLowerCase().trim();

    if (searchText.isEmpty) {
      return categoryFiltered;
    }

    return categoryFiltered.where((card) {
      return card.title.toLowerCase().contains(searchText) ||
          card.subtitle.toLowerCase().contains(searchText) ||
          card.category.toLowerCase().contains(searchText);
    }).toList();
  }

  void changeIndex(int index) {
    selectIndex.value = index;
    update();
  }
}
