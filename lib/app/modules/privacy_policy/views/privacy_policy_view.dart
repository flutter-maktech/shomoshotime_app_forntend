import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../common_widgets/custom_app_bar.dart';

import '../controllers/privacy_policy_controller.dart';
import '../../common_widgets/quill_delta_renderer.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy Policy',
        subTitle: "Your privacy is important to us",
        onTap: () => Get.back(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Text(
                controller.errorMessage.value,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.readColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final content = controller.cmsResponse.value?.data?.content;

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColors.containerColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: QuillDeltaRenderer(
                deltaString: content,
                baseStyle: AppTextStyles.regular14.apply(color: Colors.black),
              ),
            ),
          ),
        );
      }),
    );
  }
}
