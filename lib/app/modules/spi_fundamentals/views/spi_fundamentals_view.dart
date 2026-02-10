import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/log.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controllers/spi_fundamentals_controller.dart';

class SpiFundamentalsView extends GetView<SpiFundamentalsController> {
  const SpiFundamentalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Obx(
            () => SliverToBoxAdapter(
              child: CustomAppBar(title: controller.title.value),
            ),
          ),
          Obx(() {
            if (controller.pdfUrl.isEmpty) {
              return SliverToBoxAdapter(
                child: Container(
                  height: 500.h,
                  margin: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: AppColors.appBarBack,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'PDF URL not provided',
                      style: AppTextStyles.regular14,
                    ),
                  ),
                ),
              );
            }

            return Obx(() {
              // Use dynamic height based on page size
              double containerHeight = controller.pageSize.value.isEmpty
                  ? 500
                        .h // Default height
                  : _calculateHeightFromPageSize(
                      controller.pageSize.value,
                      context,
                    );

              return SliverToBoxAdapter(
                child: Container(
                  height: containerHeight,
                  margin: EdgeInsets.all(16.h),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      if (controller.localPdfPath.value.isNotEmpty)
                        SfPdfViewer.file(
                          File(controller.localPdfPath.value),
                          canShowScrollHead: false,
                          pageSpacing: 0,
                          canShowPageLoadingIndicator: false,
                          pageLayoutMode: PdfPageLayoutMode.single,
                          controller: controller.pdfViewerController,
                          scrollDirection: PdfScrollDirection.horizontal,
                          // In SpiFundamentalsView.dart - update the onDocumentLoaded callback
                          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                            // Get first page size
                            final firstPage = details.document.pages[0];
                            final pageWidth = firstPage.size.width;
                            final pageHeight = firstPage.size.height;

                            // Store page size in controller
                            controller.pageSize.value =
                                '${pageWidth}x${pageHeight}';

                            // Calculate aspect ratio
                            final aspectRatio = pageWidth / pageHeight;
                            controller.aspectRatio.value = aspectRatio;

                            controller.totalPages.value =
                                details.document.pages.count;
                            controller.isLoadingPdf.value = false;
                            controller.pdfErrorMessage.value = '';

                            // Track initial page view
                            controller.trackInitialPageView();
                          },
                          onDocumentLoadFailed:
                              (PdfDocumentLoadFailedDetails details) {
                                controller.handlePdfError(details.description);
                                AppLogger.log(
                                  'PDF load failed: ${details.description}',
                                );
                              },
                          onPageChanged: (PdfPageChangedDetails details) {
                            controller.page.value = details.newPageNumber;
                          },
                        ),

                      // Loading indicator
                      if (controller.isLoadingPdf.value)
                        Container(
                          color: AppColors.appBarBack,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                      // Error message
                      if (controller.pdfErrorMessage.value.isNotEmpty)
                        Container(
                          color: AppColors.appBarBack,
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 48,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Failed to load PDF',
                                  style: AppTextStyles.bold18,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  controller.pdfErrorMessage.value,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.regular14.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: controller.retryPdfLoad,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text('Retry'),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            });
          }),

          // Page indicator
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          Obx(
            () => SliverToBoxAdapter(
              child: Center(
                child: Text(
                  '${controller.page.value} / ${controller.totalPages.value} Pages',
                  style: AppTextStyles.regular12,
                ),
              ),
            ),
          ),

          // Navigation buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      childText: 'Back',
                      buttonColor: AppColors.lightYellow,
                      onTap: controller.previousPage,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButton(
                      childText: 'Next',
                      buttonColor: AppColors.lightYellow,
                      onTap: () {
                        controller.nextPage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Download button with progress indicator
          SliverToBoxAdapter(
            child: Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (controller.isDownloading.value)
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: controller.downloadProgress.value,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            controller.downloadStatus.value,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),

                    CustomButton(
                      childText: controller.isDownloading.value
                          ? 'Downloading...'
                          : 'Download PDF',
                      onTap: controller.isDownloading.value
                          ? null
                          : controller.downloadPdf,
                      buttonColor: controller.isDownloading.value
                          ? AppColors.greenColor
                          : AppColors.lightYellow,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateHeightFromPageSize(String pageSize, BuildContext context) {
    try {
      final dimensions = pageSize.split('x');
      final width = double.parse(dimensions[0]);
      final height = double.parse(dimensions[1]);

      // Get screen width minus margins
      final screenWidth =
          MediaQuery.of(context).size.width - 32.h; // 16+16 margin

      // Calculate height based on aspect ratio
      final aspectRatio = height / width;
      final calculatedHeight = screenWidth * aspectRatio;

      // Add some padding and limit max height
      final maxHeight = MediaQuery.of(context).size.height * 0.7;
      return calculatedHeight.clamp(300.h, maxHeight);
    } catch (e) {
      return 500.h; // Default if parsing fails
    }
  }
}
