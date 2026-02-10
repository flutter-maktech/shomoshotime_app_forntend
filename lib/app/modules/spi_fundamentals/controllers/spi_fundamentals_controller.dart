import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/all_utils/log.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';

class SpiFundamentalsController extends GetxController {
  // PDF Viewer Controller
  late PdfViewerController pdfViewerController;
  RxString pageSize = ''.obs;
  RxDouble aspectRatio = 0.0.obs;
  RxInt contentId = 0.obs;
  RxString localPdfPath = ''.obs;
  int lastReadPage = 1;
  final NetworkCaller _networkCaller = NetworkCaller();

  // Track previous page to avoid duplicate API calls
  int _lastTrackedPage = 0;
  bool _isInitialLoad = true;

  // Page tracking
  RxInt page = 1.obs;
  RxInt totalPages = 0.obs;

  // Download state
  RxBool isDownloading = false.obs;
  RxDouble downloadProgress = 0.0.obs;
  RxString downloadStatus = ''.obs;

  // Authentication
  RxString authToken = ''.obs;

  // PDF Loading state
  RxBool isLoadingPdf = true.obs;
  RxString pdfErrorMessage = ''.obs;

  // Make these observable
  RxString pdfUrl = ''.obs;
  RxString title = ''.obs;

  @override
  void onInit() {
    super.onInit();
    pdfViewerController = PdfViewerController();

    // Load token first, then handle arguments to avoid race condition with headers
    _initData();

    // Listen to page changes
    pdfViewerController.addListener(() {
      final newPage = pdfViewerController.pageNumber;
      // Update the page observable
      page.value = newPage;

      // Track page change via API (skip initial load and same page)
      if (!_isInitialLoad && newPage != _lastTrackedPage) {
        _callPageChangeApi(newPage);
        _lastTrackedPage = newPage;
      }
    });
  }

  Future<void> _initData() async {
    try {
      isLoadingPdf.value = true;
      _isInitialLoad = true;
      _lastTrackedPage = 0;

      // 1. Load token
      authToken.value = await AppPreference.getToken() ?? '';

      // 2. Handle arguments
      if (Get.arguments != null) {
        final args = Get.arguments as Map<String, dynamic>;
        final filePath = args['pdfUrl'] as String? ?? '';
        final id = args['contentId'] as int? ?? 0;
        lastReadPage = args['lastPage'] as int? ?? 1;

        AppLogger.log('Original file path: $filePath');
        AppLogger.log('Content ID: $id');
        AppLogger.log('Last read page: $lastReadPage');

        // Assign values
        pdfUrl.value = filePath;
        contentId.value = id;
        title.value = args['title'] as String? ?? 'SPI Fundamentals';

        AppLogger.log('Final PDF URL: ${pdfUrl.value}');

        // 3. Handle local PDF
        await _handleLocalPdf(filePath);
      } else {
        pdfUrl.value = '';
        contentId.value = 0;
        title.value = 'SPI Fundamentals';
        isLoadingPdf.value = false;
        _isInitialLoad = false;
      }
    } catch (e) {
      handlePdfError('Initialization failed: $e');
      _isInitialLoad = false;
    }
  }

  Future<void> _handleLocalPdf(String url) async {
    if (url.isEmpty) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = url.split('/').last;
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      if (await file.exists()) {
        AppLogger.log('PDF already exists locally: $filePath');
        localPdfPath.value = filePath;
        isLoadingPdf.value = false;
      } else {
        AppLogger.log('Downloading PDF to local cache...');
        downloadStatus.value = 'Downloading PDF...';

        final dio = Dio();
        final Map<String, String> headers = {
          'Authorization': 'Bearer ${authToken.value}',
        };

        await dio.download(
          url,
          filePath,
          options: Options(headers: headers),
          onReceiveProgress: (received, total) {
            if (total != -1) {
              downloadProgress.value = received / total;
            }
          },
        );

        localPdfPath.value = filePath;
        isLoadingPdf.value = false;
        AppLogger.log('PDF downloaded to: $filePath');
      }
    } catch (e) {
      AppLogger.log('Error handling local PDF: $e');
      // If local storage fails, we can fall back to network if needed,
      // but the user explicitly asked to download and THEN show.
      handlePdfError('Failed to prepare PDF: $e');
    }
  }

  // Method to track page change via API
  Future<void> _callPageChangeApi(int currentPage) async {
    try {
      // Don't call API if contentId is 0 (not set)
      if (contentId.value == 0) {
        AppLogger.log(
          'Content ID not set, skipping API call for page $currentPage',
        );
        return;
      }

      // Don't track page 0 or invalid pages
      if (currentPage <= 0 || currentPage > totalPages.value) {
        AppLogger.log('Invalid page number $currentPage, skipping API call');
        return;
      }

      AppLogger.log('Tracking page change to: $currentPage');

      // Prepare request body
      final Map<String, dynamic> requestBody = {
        "content_id": contentId.value,
        "page_number": currentPage,
      };

      // Call API using your NetworkCaller
      final response = await _networkCaller.postRequest(
        Urls.nextPage,
        requestBody,
        token: authToken.value,
      );

      // Handle response
      if (response['success'] == true) {
        AppLogger.log(
          'Page $currentPage tracked successfully: ${response['message']}',
        );
      } else {
        AppLogger.log(
          'Failed to track page $currentPage: ${response['message']}',
        );
      }
    } catch (e) {
      AppLogger.log('Error tracking page change to $currentPage: $e');
    }
  }

  // Track initial page view when PDF loads
  void trackInitialPageView() {
    if (contentId.value != 0 && _isInitialLoad) {
      // Jump to last read page if it's not the first page
      if (lastReadPage > 1 && lastReadPage <= totalPages.value) {
        AppLogger.log('Jumping to last read page: $lastReadPage');
        pdfViewerController.jumpToPage(lastReadPage);
        _lastTrackedPage = lastReadPage;
      } else {
        // Track first page view if we're starting from page 1
        _callPageChangeApi(1);
        _lastTrackedPage = 1;
      }
      _isInitialLoad = false;
    }
  }

  // Handle PDF loading errors
  void handlePdfError(String message) {
    isLoadingPdf.value = false;
    pdfErrorMessage.value = message;
    AppLogger.log('PDF Loading Error: $message');
    _isInitialLoad = false;
  }

  // Reset PDF loading state
  void retryPdfLoad() {
    isLoadingPdf.value = true;
    pdfErrorMessage.value = '';
    _isInitialLoad = true;
    _lastTrackedPage = 0;
  }

  // Navigation methods - simplified since tracking is automatic
  void nextPage() {
    pdfViewerController.nextPage();
  }

  void previousPage() {
    pdfViewerController.previousPage();
  }

  void jumpToPage(int pageNumber) {
    pdfViewerController.jumpToPage(pageNumber);
  }

  // Download PDF method
  Future<void> downloadPdf() async {
    try {
      // Check storage permission
      if (!await _requestStoragePermission()) {
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Storage permission is required to download files'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      }

      isDownloading.value = true;
      downloadStatus.value = 'Preparing download...';
      downloadProgress.value = 0.0;

      // Get downloads directory
      final directory = await getDownloadsDirectory();
      if (directory == null) {
        throw Exception('Could not access downloads directory');
      }

      // Create file name from URL
      final fileName = pdfUrl.value.split('/').last;
      final filePath = '${directory.path}/$fileName';

      // If file exists in local cache, copy it instead of downloading again
      if (localPdfPath.value.isNotEmpty &&
          await File(localPdfPath.value).exists()) {
        downloadStatus.value = 'Saving to file manager...';
        downloadProgress.value = 0.5;
        await File(localPdfPath.value).copy(filePath);
        downloadProgress.value = 1.0;
      } else {
        // Download using Dio
        final dio = Dio();

        // Add authorization header with your token
        final Map<String, String> headers = {
          'Authorization': 'Bearer ${authToken.value}',
          'Content-Type': 'application/pdf',
          'Accept': 'application/pdf',
        };

        await dio.download(
          pdfUrl.value,
          filePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              downloadProgress.value = received / total;
              downloadStatus.value =
                  'Downloading: ${(downloadProgress.value * 100).toStringAsFixed(1)}%';
            }
          },
          options: Options(headers: headers),
        );
      }

      // Download complete
      isDownloading.value = false;
      downloadStatus.value = 'Download complete!';

      // Show success message
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('PDF downloaded successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Open the downloaded file
      final result = await OpenFilex.open(filePath);
      AppLogger.log('Open file result: ${result.message}');
    } catch (e) {
      isDownloading.value = false;
      downloadStatus.value = 'Download failed: $e';
      AppLogger.log('Download error details: $e');

      // Show error message
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Failed to download PDF. Please try again.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Request storage permission
  Future<bool> _requestStoragePermission() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;

        if (sdkInt >= 33) {
          final status = await Permission.photos.status;
          if (!status.isGranted) {
            final result = await Permission.photos.request();
            return result.isGranted;
          }
          return true;
        } else {
          final status = await Permission.storage.status;
          if (!status.isGranted) {
            final result = await Permission.storage.request();
            return result.isGranted;
          }
          return true;
        }
      } else if (Platform.isIOS) {
        final status = await Permission.photos.status;
        if (!status.isGranted) {
          final result = await Permission.photos.request();
          return result.isGranted;
        }
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.log('Permission error: $e');
      return false;
    }
  }

  @override
  void onClose() {
    pdfViewerController.dispose();
    super.onClose();
  }
}
