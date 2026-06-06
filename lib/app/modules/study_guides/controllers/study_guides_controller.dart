import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../../all_utils/log.dart';

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
    if (select.value == index) return;

    select.value = index;

    // Reset category filter when switching between PDF and Audio tabs
    selectIndex.value = 0;
    selectedCategory.value = 'All';

    // Clear search when switching tabs
    clearSearch();

    AppLogger.log(
      'Switched to ${index == 0 ? "PDF" : "Audio"} view, reset category to All',
    );

    refreshStudyGuides();
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

  Future<void> filterStudyGuides(String categoryName) async {
    setSelectedCategory(categoryName);
    await refreshStudyGuides();
  }

  // Filter by file type AND search query locally
  List<StudyGuide> getLocalFilteredGuides(
    List<StudyGuide> studyGuides,
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

    // Finally filter by search query
    if (searchQuery.isEmpty) {
      return filteredByType;
    }

    return filteredByType.where((guide) {
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

  Future<void> playAudio(String url, {String? title, String? subtitle}) async {
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
          AppLogger.log('Restored audio progress: $savedSeconds seconds');
        }

        // Set just_audio source with metadata for lock screen integration
        await audioPlayer.setAudioSource(
          AudioSource.uri(
            Uri.parse(url),
            tag: MediaItem(
              id: url,
              album: "Study Guides",
              title: title ?? "Study Guide Audio",
              artist: subtitle ?? "Sonographer Pal",
            ),
          ),
          initialPosition: position.value,
        );
      }

      if (isPlaying.value && currentAudioUrl.value == url) {
        await pauseAudio();
        return;
      }

      await audioPlayer.play();
    } catch (e) {
      AppLogger.log('Audio play error: $e');
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
    await audioPlayer.play();
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
  var isFetching = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Clear search when controller is initialized
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });

    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      isLoading.value =
          state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;
    });

    audioPlayer.durationStream.listen((d) {
      duration.value = d ?? Duration.zero;
    });

    audioPlayer.positionStream.listen((p) {
      position.value = p;
      // Save progress every 5 seconds
      if (p.inSeconds > 0 &&
          p.inSeconds % 5 == 0 &&
          currentAudioUrl.value.isNotEmpty) {
        AppPreference.saveAudioProgress(currentAudioUrl.value, p.inSeconds);
      }
    });

    audioPlayer.setLoopMode(LoopMode.one);

    fetchStudyGuides();

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
    isFetching.value = true;
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
        isFetching.value = true;
      } else {
        isLoadingMore.value = true;
      }

      final token = await AppPreference.getToken();

      // Assuming API accepts 'page' in body or query param
      // Based on previous code, it's a POST request with body
      final body = <String, dynamic>{'page': page.toString()};

      if (selectedCategory.value != 'All') {
        body['category'] = selectedCategory.value;
      }

      body['file_type'] = select.value == 0 ? 'pdf' : 'audio';

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
      AppLogger.log('Error fetching study guides: $e');
    } finally {
      isFetching.value = false;
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
