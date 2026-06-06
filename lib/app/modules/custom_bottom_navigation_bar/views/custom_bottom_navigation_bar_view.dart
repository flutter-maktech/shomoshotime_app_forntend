import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../controllers/custom_bottom_navigation_bar_controller.dart';

class CustomBottomNavigationBarView
    extends GetView<CustomBottomNavigationBarController> {
  const CustomBottomNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // ---------- BODY ----------
        body: controller.getCurrentPage(),

        // ---------- BOTTOM NAV ----------
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.whiteColor,
            onTap: controller.changeIndex,
            currentIndex: controller.currentIndex.value,
            elevation: 6,
            unselectedLabelStyle: AppTextStyles.regular10,
            selectedLabelStyle: AppTextStyles.regular10,
            selectedItemColor: AppColors.blackColor,
            showUnselectedLabels: true,
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
                iconImage: ImagePath.cardIcon,
                index: 2,
                labelText: 'FlashCards',
              ),
              _buildBottomNavigationBarItem(
                iconImage: ImagePath.brainIcon,
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
      ),
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
          radius: 16.r, // control size
          backgroundColor: isSelected
              ? AppColors.primaryColor
              : AppColors.disableBottomNavColor,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : AppColors.bottomNavIconColor,
              BlendMode.srcIn,
            ),
            child: Image.asset(iconImage, height: 26, width: 26),
          ),
        );
      }),
      label: labelText,
    );
  }
}
