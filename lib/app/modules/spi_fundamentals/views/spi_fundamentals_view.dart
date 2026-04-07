import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_button.dart';
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
                  height: 550.h,
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

            return SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: const BoxDecoration(color: AppColors.appBarBack),
                child: Stack(
                  children: [
                    // PDF Viewer
                    Obx(
                      () => controller.localPdfPath.value.isNotEmpty
                          ? SfPdfViewer.file(
                              File(controller.localPdfPath.value),
                              canShowScrollHead: false,
                              pageSpacing: 0,
                              canShowPageLoadingIndicator: false,
                              pageLayoutMode: PdfPageLayoutMode.single,
                              controller: controller.pdfViewerController,
                              scrollDirection: PdfScrollDirection.horizontal,
                              onDocumentLoaded:
                                  (PdfDocumentLoadedDetails details) {
                                    controller.totalPages.value =
                                        details.document.pages.count;
                                    controller.isLoadingPdf.value = false;
                                    controller.pdfErrorMessage.value = '';

                                    // Track initial page view
                                    controller.trackInitialPageView();
                                  },
                              onDocumentLoadFailed:
                                  (PdfDocumentLoadFailedDetails details) {
                                    controller.handlePdfError(
                                      details.description,
                                    );
                                  },
                              onPageChanged: (PdfPageChangedDetails details) {
                                controller.page.value = details.newPageNumber;
                              },
                            )
                          : const SizedBox.shrink(),
                    ),

                    // Loading indicator
                    Obx(
                      () => controller.isLoadingPdf.value
                          ? Container(
                              color: AppColors.appBarBack,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Preparing Study Material...',
                                      style: AppTextStyles.regular14,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    // Error message
                    Obx(
                      () => controller.pdfErrorMessage.value.isNotEmpty
                          ? Container(
                              color: AppColors.appBarBack,
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Failed to load PDF',
                                      style: AppTextStyles.bold18,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      controller.pdfErrorMessage.value,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.regular14.copyWith(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton(
                                      onPressed: controller.retryPdfLoad,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryColor,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
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
        ],
      ),
    );
  }
}
