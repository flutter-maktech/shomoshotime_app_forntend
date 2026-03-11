import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../all_utils/log.dart';
import '../../home/controllers/home_controller.dart';

import '../../../core/user_panel_model/study_guide_response_model.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../all_utils/app_preference.dart';

class StudyGuidesController extends GetxController {
  RxInt select = 0.obs;
  TextEditingController searchController = TextEditingController();
  RxString searchQuery = ''.obs;

  void confirmFileUsage(StudyGuide guide) {
    if (guide.fileType?.toLowerCase() == 'pdf') {
      AppLogger.log(
        'PDF Usage Confirmed: Title = ${guide.title}, File = ${guide.file}',
      );
    } else {
      AppLogger.log(
        'Audio Usage Confirmed: Title = ${guide.title}, FileUrl = ${guide.fileUrl}',
      );
    }
  }

  void changeValue(int index) {
    select.value = index;

    // Reset category filter when switching between PDF and Audio tabs
    selectIndex.value = 0;
    selectedCategory.value = 'All';

    // Clear search when switching tabs
    clearSearch();

    AppLogger.log(
      'Switched to ${index == 0 ? "PDF" : "Audio"} view, reset category to All',
    );
  }

  void onSearchChanged(String query) {
    searchQuery.value = query.trim();
    AppLogger.log('Search query: $query');
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
        : filteredByType
              .where(
                (guide) =>
                    guide.category.toLowerCase() == category.toLowerCase(),
              )
              .toList();

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
  List<String> getCategoriesForView(
    List<StudyGuide> studyGuides,
    bool isAudioView,
  ) {
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
  var isLoading = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;
  RxString currentAudioUrl = ''.obs;

  Future<void> playAudio(String url) async {
    AppLogger.log(
      'Confirming Audio usage: Source URL = $url (Using fileUrl field)',
    );
    try {
      if (currentAudioUrl.value != url) {
        await audioPlayer.stop(); // stop previous audio
        position.value = Duration.zero;
        currentAudioUrl.value = url;

        // Restore progress
        final savedSeconds = await AppPreference.getAudioProgress(url);
        if (savedSeconds > 0) {
          position.value = Duration(seconds: savedSeconds);
          await audioPlayer.seek(position.value);
          AppLogger.log('Restored audio progress: $savedSeconds seconds');
        }
      }

      if (isPlaying.value && currentAudioUrl.value == url) {
        await pauseAudio();
        return;
      }

      isLoading.value = true;
      await audioPlayer.play(UrlSource(url));
    } catch (e) {
      AppLogger.log('Audio play error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
    if (currentAudioUrl.value.isNotEmpty) {
      await AppPreference.saveAudioProgress(
        currentAudioUrl.value,
        position.value.inSeconds,
      );
    }
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

  // Pagination variables
  final allStudyGuides = <StudyGuide>[].obs;
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int lastPage = 1;
  var isLoadingMore = false.obs;
  var isRefreshing = false.obs;

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
      // Save progress every 5 seconds
      if (p.inSeconds > 0 &&
          p.inSeconds % 5 == 0 &&
          currentAudioUrl.value.isNotEmpty) {
        AppPreference.saveAudioProgress(currentAudioUrl.value, p.inSeconds);
      }
    });

    audioPlayer.setReleaseMode(ReleaseMode.loop);

    // Check if HomeController has already fetched the first page of study guides
    bool dataInitialized = false;
    if (Get.isRegistered<HomeController>()) {
      final homeController = Get.find<HomeController>();
      final homeData = homeController.studyGuideResponse.value;
      if (homeData != null && homeData.data.isNotEmpty) {
        allStudyGuides.assignAll(homeData.data);
        currentPage = homeData.meta.currentPage;
        lastPage = homeData.meta.lastPage;
        dataInitialized = true;
        ('StudyGuidesController: Initialized from HomeController data',);
      }
    }

    // Initial fetch only if not initialized from HomeController
    if (!dataInitialized) {
      fetchStudyGuides();
    }

    // Scroll listener for pagination
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (!scrollController.hasClients) return;

    for (final position in scrollController.positions) {
      if (position.pixels >= position.maxScrollExtent) {
        if (currentPage < lastPage && !isLoadingMore.value) {
          fetchStudyGuides(page: currentPage + 1);
          break; // Trigger once
        }
      }
    }
  }

  Future<void> refreshStudyGuides() async {
    isRefreshing.value = true;
    currentPage = 1;
    lastPage = 1;
    allStudyGuides.clear();
    await fetchStudyGuides(page: 1);
    isRefreshing.value = false;
  }

  final NetworkCaller _networkCaller = NetworkCaller();

  Future<void> fetchStudyGuides({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final token = await AppPreference.getToken();

      // Assuming API accepts 'page' in body or query param
      // Based on previous code, it's a POST request with body
      final body = {'page': page.toString()};

      final response = await _networkCaller.postRequest(
        Urls.studyGuideList,
        body,
        token: token,
      );

      final studyGuideResponse = StudyGuideResponse.fromJson(response);

      if (studyGuideResponse.success) {
        if (page == 1) {
          allStudyGuides.assignAll(studyGuideResponse.data);
        } else {
          allStudyGuides.addAll(studyGuideResponse.data);
        }

        currentPage = studyGuideResponse.meta.currentPage;
        lastPage = studyGuideResponse.meta.lastPage;
      }
    } catch (e) {
      ('Error fetching study guides: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    audioPlayer.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
