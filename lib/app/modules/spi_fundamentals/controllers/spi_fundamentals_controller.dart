import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/core/urls/urls.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SpiFundamentalsController extends GetxController {
  // PDF Viewer Controller
  late PdfViewerController pdfViewerController;

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

  // In SpiFundamentalsController.dart
  @override
  void onInit() {
    super.onInit();
    pdfViewerController = PdfViewerController();

    // Load token first, then handle arguments to avoid race condition with headers
    _initData();

    // Listen to page changes
    pdfViewerController.addListener(() {
      page.value = pdfViewerController.pageNumber;
    });
  }

  Future<void> _initData() async {
    try {
      isLoadingPdf.value = true;

      // 1. Load token
      authToken.value = await AppPreference.getToken() ?? '';
      print('kl;: ${authToken.value.isNotEmpty ? 'YES' : 'NO'}');

      // 2. Handle arguments
      if (Get.arguments != null) {
        final args = Get.arguments as Map<String, dynamic>;
        final filePath = args['pdfUrl'] as String? ?? '';

        print('Original file path: $filePath');

        if (filePath.startsWith('http://') || filePath.startsWith('https://')) {
          pdfUrl.value = filePath;
        } else {
          pdfUrl.value = _constructFullUrl(filePath);
        }

        title.value = args['title'] as String? ?? 'SPI Fundamentals';
        print('Final PDF URL: ${pdfUrl.value}');
      } else {
        pdfUrl.value = '';
        title.value = 'SPI Fundamentals';
        isLoadingPdf.value = false;
      }
    } catch (e) {
      handlePdfError('Initialization failed: $e');
    }
  }

  // Handle PDF loading errors
  void handlePdfError(String message) {
    isLoadingPdf.value = false;
    pdfErrorMessage.value = message;
    print('PDF Loading Error: $message');
  }

  // Reset PDF loading state
  void retryPdfLoad() {
    isLoadingPdf.value = true;
    pdfErrorMessage.value = '';
  }

  // Helper method to construct full URL
  String _constructFullUrl(String relativePath) {
    if (relativePath.isEmpty) return '';

    // Remove leading slash if present
    final cleanPath = relativePath.startsWith('/')
        ? relativePath.substring(1)
        : relativePath;

    // Use the central base domain
    return '${Urls.baseDomain}/$cleanPath';
  }

  // Navigation methods
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
        Get.snackbar(
          'Permission Required',
          'Storage permission is required to download files',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
      final fileName = pdfUrl.split('/').last;
      final filePath = '${directory.path}/$fileName';

      // Download using Dio
      final dio = Dio();

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
        options: Options(
          headers: {
            if (authToken.isNotEmpty)
              'Authorization': 'Bearer ${authToken.value}',
          },
        ),
      );

      // Download complete
      isDownloading.value = false;
      downloadStatus.value = 'Download complete!';

      // Show success message
      Get.snackbar(
        'Success',
        'PDF downloaded successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );

      // Open the downloaded file
      final result = await OpenFilex.open(filePath);
      print('Open file result: ${result.message}');
    } catch (e) {
      isDownloading.value = false;
      downloadStatus.value = 'Download failed: $e';

      Get.snackbar(
        'Download Failed',
        'Failed to download PDF: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  // Request storage permission
  Future<bool> _requestStoragePermission() async {
    final status = await Permission.storage.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      final result = await Permission.storage.request();
      return result.isGranted;
    } else if (status.isPermanentlyDenied) {
      // Open app settings
      await openAppSettings();
      return false;
    }

    return false;
  }

  @override
  void onClose() {
    pdfViewerController.dispose();
    super.onClose();
  }
}
