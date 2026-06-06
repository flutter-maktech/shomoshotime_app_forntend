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
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: const BoxDecoration(color: AppColors.appBarBack),
                child: Stack(
                  children: [
                    // PDF Viewer
                    Obx(() {
                      if (controller.localPdfPath.value.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return RotatedBox(
                        quarterTurns: controller.isCurrentPageRotated() ? 1 : 0,
                        child: SfPdfViewer.file(
                          File(controller.localPdfPath.value),
                          canShowScrollHead: false,
                          pageSpacing: 0,
                          canShowPageLoadingIndicator: false,
                          pageLayoutMode: PdfPageLayoutMode.single,
                          controller: controller.pdfViewerController,
                          scrollDirection: PdfScrollDirection.horizontal,
                          onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                            controller.totalPages.value =
                                details.document.pages.count;
                            controller.isLoadingPdf.value = false;
                            controller.pdfErrorMessage.value = '';

                            // Load page dimensions/sizes
                            controller.loadPageSizes(details.document);

                            // Track initial page view
                            controller.trackInitialPageView();

                            // Show rotation tooltip next to the button for 3 seconds
                            controller.triggerTooltip();
                          },
                          onDocumentLoadFailed:
                              (PdfDocumentLoadFailedDetails details) {
                                controller.handlePdfError(details.description);
                              },
                          onPageChanged: (PdfPageChangedDetails details) {
                            controller.page.value = details.newPageNumber;
                          },
                        ),
                      );
                    }),

                    // Rotate Page Button & Tooltip
                    Obx(() {
                      if (controller.localPdfPath.value.isEmpty ||
                          controller.isLoadingPdf.value ||
                          controller.pdfErrorMessage.value.isNotEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Beautiful animated tooltip message next to the button
                            AnimatedOpacity(
                              opacity: controller.showRotationTooltip.value
                                  ? 1.0
                                  : 0.0,
                              duration: const Duration(milliseconds: 300),
                              child: IgnorePointer(
                                ignoring: !controller.showRotationTooltip.value,
                                child: Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    'Tap here to view in landscape mode',
                                    style: AppTextStyles.regular12.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Rotate button itself
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: controller.togglePageRotation,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: EdgeInsets.all(8.h),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white24,
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(
                                    controller.isCurrentPageRotated()
                                        ? Icons.screen_rotation
                                        : Icons.crop_rotate,
                                    color: Colors.white,
                                    size: 20.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

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
