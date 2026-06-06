import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../custom_bottom_navigation_bar/controllers/custom_bottom_navigation_bar_controller.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/primary_app_bar.dart';
import '../controllers/home_controller.dart';
import '../widgets/background_container.dart';
import '../widgets/flash_card_listview.dart';
import '../widgets/selection_header_row.dart';
import '../widgets/study_guide_listview.dart';
import '../widgets/study_header_info.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background container with decorative design
          const BackGroundContainer(),

          // Main content area
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App bar with notification and profile navigation
                PrimaryAppBar(
                  notificationOnTap: () => Get.toNamed(Routes.notification),
                  profileOnTap: () {
                    Get.toNamed(Routes.profile);
                  },
                ),
                SizedBox(height: 10.h),
                // Scrollable content area
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        // User welcome section with study statistics
                        const StudyHeaderInfo(),

                        // Main content sections
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              // Flash Cards section header
                              SectionHeaderRow(
                                title: 'Flash Cards',
                                subtitle: 'Pick up where you left off',
                                onViewAllTap: () {
                                  final bottomBarController =
                                      Get.find<
                                        CustomBottomNavigationBarController
                                      >();
                                  bottomBarController.changeIndex(2);
                                },
                              ),

                              SizedBox(height: 22.h),

                              // List of flash cards
                              const FlashCardListView(),

                              SizedBox(height: 45.h),

                              // Study Guide section header
                              SectionHeaderRow(
                                title: 'Study Guide',
                                subtitle: 'Your mastery across specialties',
                                onViewAllTap: () {
                                  final bottomBarController =
                                      Get.find<
                                        CustomBottomNavigationBarController
                                      >();
                                  bottomBarController.changeIndex(1);
                                },
                              ),

                              SizedBox(height: 22.h),

                              // List of study guides with progress indicators
                              const StudyGuideListView(),

                              // Bottom spacing
                              SizedBox(height: 25.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
