import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

            return SliverToBoxAdapter(
              child: Container(
                height: 500.h,
                margin: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      SfPdfViewer.network(
                        controller.pdfUrl.value,
                        canShowScrollHead: false,
                        pageSpacing: 0,
                        // backgroundColor: Colors.white,
                        pageLayoutMode: PdfPageLayoutMode.single,
                        controller: controller.pdfViewerController,
                        scrollDirection: PdfScrollDirection.vertical,
                        onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                          controller.totalPages.value =
                              details.document.pages.count;
                          controller.isLoadingPdf.value = false;
                          controller.pdfErrorMessage.value = '';
                        },
                        onDocumentLoadFailed:
                            (PdfDocumentLoadFailedDetails details) {
                              controller.handlePdfError(details.description);
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
                      onTap: controller.nextPage,
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
                          ? Colors.grey
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
}
