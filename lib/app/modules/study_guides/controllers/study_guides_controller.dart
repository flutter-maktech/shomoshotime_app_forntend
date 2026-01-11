// StudyGuidesController.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/user_panel_model/study_guide_response_model.dart';

class StudyGuidesController extends GetxController {
  RxInt select = 0.obs;
  TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;
  
  void changeValue(int index) {
    select.value = index;
    
    // Reset category filter when switching between PDF and Audio tabs
    selectIndex.value = 0;
    selectedCategory.value = 'All';
    
    // Clear search when switching tabs
    clearSearch();
    
    print('Switched to ${index == 0 ? "PDF" : "Audio"} view, reset category to All');
  }
  
  void onSearchChanged(String query) {
    searchQuery.value = query.trim();
    print('Search query: $query');
  }
  
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  var selectIndex = 0.obs;
  var selectedCategory = 'All'.obs;

  void changeIndex(int index) {
    selectIndex.value = index;
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  // Filter by category AND search query
  List<StudyGuide> filterStudyGuides(
    List<StudyGuide> studyGuides,
    String category,
    String searchQuery,
    bool isAudioView,
  ) {
    // First filter by file type
    List<StudyGuide> filteredByType = studyGuides.where((guide) {
      final fileType = guide.fileType?.toLowerCase() ?? '';
      if (isAudioView) {
        return fileType == 'mp3' ||
               fileType == 'm4a' ||
               fileType == 'wav' ||
               fileType == 'audio' ||
               fileType == 'aac';
      } else {
        return fileType == 'pdf';
      }
    }).toList();

    // Then filter by category
    List<StudyGuide> filteredByCategory = (category == 'All')
        ? filteredByType
        : filteredByType.where((guide) => guide.category == category).toList();

    // Finally filter by search query
    if (searchQuery.isEmpty) {
      return filteredByCategory;
    }

    return filteredByCategory.where((guide) {
      final title = guide.title.toLowerCase();
      final subtitle = guide.subtitle.toLowerCase();
      final category = guide.category.toLowerCase();
      final query = searchQuery.toLowerCase();
      
      return title.contains(query) || 
             subtitle.contains(query) || 
             category.contains(query);
    }).toList();
  }

  // For category filter bar - get unique categories for current view
  List<String> getCategoriesForView(List<StudyGuide> studyGuides, bool isAudioView) {
    // Filter by file type
    final filteredGuides = studyGuides.where((guide) {
      final fileType = guide.fileType?.toLowerCase() ?? '';
      if (isAudioView) {
        return fileType == 'mp3' ||
               fileType == 'm4a' ||
               fileType == 'wav' ||
               fileType == 'audio' ||
               fileType == 'aac';
      } else {
        return fileType == 'pdf';
      }
    }).toList();

    final categories = filteredGuides
        .map((guide) => guide.category)
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList();

    categories.sort();
    return categories;
  }

  final audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Clear search when controller is initialized
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    audioPlayer.onDurationChanged.listen((d) {
      duration.value = d;
    });

    audioPlayer.onPositionChanged.listen((p) {
      position.value = p;
    });

    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> playAudio(String url) async {
    await audioPlayer.play(UrlSource(url));
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> resumeAudio() async {
    await audioPlayer.resume();
  }

  Future<void> seekTo(Duration pos) async {
    await audioPlayer.seek(pos);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void onClose() {
    searchController.dispose();
    audioPlayer.dispose();
    super.onClose();
  }
}