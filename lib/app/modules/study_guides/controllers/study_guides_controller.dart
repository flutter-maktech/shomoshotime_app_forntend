import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../../core/user_panel_model/study_guide_response_model.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../all_utils/app_preference.dart';

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

    print(
      'Switched to ${index == 0 ? "PDF" : "Audio"} view, reset category to All',
    );
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
  final Map<String, String> _localAudioPaths = {};

  // Audio download progress
  RxMap<String, double> downloadProgress = <String, double>{}.obs;

  Future<void> playAudio(String url) async {
    try {
      if (currentAudioUrl.value != url) {
        await audioPlayer.stop(); // stop previous audio
        position.value = Duration.zero;
      }

      currentAudioUrl.value = url;

      // 1️⃣ Check if we already have a local file for this URL
      String? localPath = _localAudioPaths[url];
      if (localPath != null && File(localPath).existsSync()) {
        await audioPlayer.play(DeviceFileSource(localPath));
        return;
      }

      // 2️⃣ Download audio with progress
      isLoading.value = true; // start loading
      downloadProgress[url] = 0.0; // Init progress

      final request = http.Request('GET', Uri.parse(url));
      final response = await http.Client().send(request);

      if (response.statusCode != 200) {
        throw Exception('Failed to download audio');
      }

      int contentLength = response.contentLength ?? 0;
      if (contentLength == 0 &&
          response.headers.containsKey('content-length')) {
        contentLength = int.tryParse(response.headers['content-length']!) ?? 0;
      }

      int receivedBytes = 0;
      List<int> bytes = [];

      final stream = response.stream.asBroadcastStream();

      await for (final chunk in stream) {
        bytes.addAll(chunk);
        receivedBytes += chunk.length;

        if (contentLength > 0) {
          downloadProgress[url] = receivedBytes / contentLength;
        } else {
          downloadProgress[url] = -1.0;
        }
      }

      downloadProgress.remove(url); // Download complete

      // 3️⃣ Save to temporary directory
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last;
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      _localAudioPaths[url] = filePath; // save path for this URL

      // 4️⃣ Play from local file
      await audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      debugPrint('Audio play error: $e');
      downloadProgress.remove(url); // Remove progress on error
    } finally {
      isLoading.value = false; // stop loading
    }
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
    });

    audioPlayer.setReleaseMode(ReleaseMode.loop);

    // Initial fetch
    fetchStudyGuides();

    // Scroll listener for pagination
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage < lastPage && !isLoadingMore.value) {
        fetchStudyGuides(page: currentPage + 1);
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
      debugPrint('Error fetching study guides: $e');
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

    // Delete all temp audio files
    _localAudioPaths.values.forEach((path) {
      final file = File(path);
      if (file.existsSync()) file.deleteSync();
    });

    super.onClose();
  }
}
