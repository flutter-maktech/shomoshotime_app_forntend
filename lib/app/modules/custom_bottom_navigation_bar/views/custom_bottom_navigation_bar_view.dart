import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/image_path.dart';

import '../controllers/custom_bottom_navigation_bar_controller.dart';

class CustomBottomNavigationBarView
    extends GetView<CustomBottomNavigationBarController> {
  const CustomBottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.whiteColor,
          onTap: controller.changeIndex,
          currentIndex: controller.currentIndex.value,
          elevation: 6,
          items: [
            _buildBottomNavigationBarItem(
              iconImage: ImagePath.dashBoardIcon,
              index: 0,
              labelText: 'Home',
            ),
            _buildBottomNavigationBarItem(
              iconImage: ImagePath.studyGuidesIcon,
              index: 1,
              labelText: 'Study Guides',
            ),
            _buildBottomNavigationBarItem(
              iconImage: ImagePath.flashCardIcon,
              index: 2,
              labelText: 'FlashCards',
            ),
            _buildBottomNavigationBarItem(
              iconImage: ImagePath.practiceIcon,
              index: 3,
              labelText: "Practice",
            ),
            _buildBottomNavigationBarItem(
              iconImage: ImagePath.mockExamIcon,
              index: 4,
              labelText: "Mock Exams",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.pages[controller.currentIndex.value]),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required int index,
    required String iconImage,
    required String labelText,
  }) {
    return BottomNavigationBarItem(
      icon: Obx(() {
        bool isSelected = controller.currentIndex.value == index;
        return CircleAvatar(
          backgroundColor: isSelected
              ? AppColors.primaryColor
              : AppColors.disableBottomNavColor,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : AppColors.bottomNavIconColor,
              BlendMode.srcIn,
            ),
            child: Image.asset(iconImage, height: 26),
          ),
        );
      }),
      label: labelText,
    );
  }
}
