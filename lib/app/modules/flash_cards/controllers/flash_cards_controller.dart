import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../../core/user_panel_model/flash_card_reponse_model.dart';

class FlashCardsController extends GetxController {
  final homeController = Get.find<HomeController>();

  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = ''.obs;
  final RxInt selectIndex = 0.obs;

  List<FlashCardItem> get flashCards => homeController.flashCards;

  @override
  void onInit() {
    super.onInit();

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
          (cardCategory.contains('ob') ||
              cardCategory.contains('gyn'))) {
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

