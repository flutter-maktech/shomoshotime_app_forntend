import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 20,
                shrinkWrap: true,
                physics:NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.h),
                  child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.editProfileTextField,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Avatar
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            ImagePath.notificationImage,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 12),

                        /// Text Content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lorem Ipsum is simply",
                                style: AppTextStyles.regular16,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                style: AppTextStyles.regular12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                                ),
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
