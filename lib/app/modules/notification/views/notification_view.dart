import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      appBar: CustomAppBar(title: "Notification"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
        
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value));
          }
        
          if (controller.notifications.isEmpty) {
            return Center(
              child: Text("No notifications"),
            );
          }
          final notiLength = controller.notifications.length;
          return ListView.builder(
            itemCount: notiLength,
            itemBuilder: (context, index) {
              final notiTitle = controller.notifications[index].title;
              final notiMessage = controller.notifications[index].message;
        
              // Get the first character of the title
              final firstChar = notiTitle.isNotEmpty
                  ? notiTitle[0].toUpperCase()
                  : 'N';
        
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: GestureDetector(
                  onTap: () => controller.markAsRead(
                    controller.notifications[index].id,
                  ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.notifications[index].isRead
                          ? Colors
                                .white // read background
                          : AppColors
                                .editProfileTextField, // unread background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Avatar & Text (same as before)
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFFD6D6D6),
                                    width: 8.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Text(
                                    firstChar,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notiTitle,
                                    style: AppTextStyles.regular16,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    notiMessage,
                                    style: AppTextStyles.regular12,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
        
                          /// Red dot indicator (show only if unread)
                          if (!controller.notifications[index].isRead)
                            Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
