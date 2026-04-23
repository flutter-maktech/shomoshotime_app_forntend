import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/subscription_plan_controller.dart';
import '../widget/custom_dolar_plan.dart';
import '../widget/selected_plan_activity.dart';
import '../../../all_utils/show_app_snack_bar.dart';

class SubscriptionPlanView extends GetView<SubscriptionPlanController> {
  const SubscriptionPlanView({super.key});

  // Legal URLs
  static const String _privacyPolicyUrl =
      'https://admin.sonographerpal.com/admindeshbord/privacy/view';
  static const String _termsOfUseUrl =
      'https://www.apple.com/legal/internet-services/itunes/dev/stdeula/';

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not launch $urlString',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //CustomAppBar
      appBar: const CustomAppBar(
        title: "Subscription Plan",
        subTitle: "Update your plan",
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(() {
            // 🔄 Loading
            if (controller.isLoading.value) {
              return SizedBox(
                height: Get.height,
                width: Get.width,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            // ❌ Error
            if (controller.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: AppTextStyles.regular16,
                ),
              );
            }

            // ❗ No data
            if (controller.subscriptions.isEmpty) {
              return const Center(child: Text("No plans available"));
            }

            // Sort subscriptions by sortOrder
            final sortedSubscriptions = controller.subscriptions.toList()
              ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

            return Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                children: [
                  ...List.generate(sortedSubscriptions.length, (index) {
                    final subscription = sortedSubscriptions[index];
                    final isCurrentPlan =
                        subscription.duration.toLowerCase() ==
                        controller.currentPlanName.value.toLowerCase();

                    return Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(8.r),
                        color: index.isEven
                            ? const Color(0xffC7C7C7)
                            : Colors.black,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Premium Plan (${subscription.duration})",
                                      style: index.isOdd
                                          ? AppTextStyles.medium20.apply(
                                              color: Colors.white,
                                            )
                                          : AppTextStyles.medium20,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 7.h),
                                CustomDolarPlan(
                                  color: index.isEven
                                      ? Colors.black
                                      : Colors.white,
                                  dolartext: "\$${subscription.price}",
                                  daytext:
                                      '/ ${_getDurationText(subscription.duration)}',
                                ),
                                SizedBox(height: 7.h),
                                if (index == 0)
                                  Text(
                                    "Perfect for short-term preparation",
                                    style: AppTextStyles.light16,
                                  ),
                                if (index == 1)
                                  Text(
                                    "Every Month",
                                    style: AppTextStyles.light16.apply(
                                      color: Colors.white,
                                    ),
                                  ),
                                if (index == 2)
                                  Text(
                                    "Save 17% compared to monthly",
                                    style: AppTextStyles.light16,
                                  ),
                                SizedBox(height: 24.h),
                                CustomButton(
                                  childText: isCurrentPlan
                                      ? "Manage Subscription"
                                      : "Subscribe",
                                  buttonChildColor: index.isEven
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                  buttonColor: index.isEven
                                      ? AppColors.blackColor
                                      : AppColors.whiteColor,
                                  onTap: () {
                                    // 1️⃣ If this is current plan → Manage
                                    if (isCurrentPlan) {
                                      final String url;
                                      if (GetPlatform.isIOS) {
                                        url =
                                            'https://apps.apple.com/account/subscriptions';
                                      } else {
                                        url =
                                            'https://play.google.com/store/account/subscriptions';
                                      }
                                      _launchUrl(url);
                                      return;
                                    }

                                    // 2️⃣ If user already has ANY active plan
                                    if (controller
                                        .currentPlanName
                                        .value
                                        .isNotEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            backgroundColor:
                                                AppColors.whiteColor,
                                            title: const Text(
                                              'You already have a subscription',
                                            ),
                                            content: const Text(
                                              'You cannot subscribe to another plan until you cancel your current subscription.',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    // 3️⃣ Otherwise → Allow payment
                                    final package = controller
                                        .getPackageForSubscription(
                                          subscription.duration,
                                        );
                                    if (package != null) {
                                      controller.purchasePlan(
                                        package,
                                        subscription.id,
                                      );
                                    } else {
                                      showAppSnackBar(
                                        context: context,
                                        message: 'Plan not available in store',
                                        backgroundColor: Colors.orange,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Display features from API
                          Container(
                            padding: EdgeInsets.only(
                              bottom: index < sortedSubscriptions.length - 1
                                  ? 5.h
                                  : 0,
                              top: 15.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                              color: index.isEven
                                  ? const Color(0xffe8e6e6)
                                  : const Color(0xffe5cf87),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.r),
                              child: Column(
                                children: subscription.features.map((feature) {
                                  return Column(
                                    children: [
                                      SelectedPlanActivity(text: feature),
                                      const Divider(
                                        color: Colors.black,
                                        thickness: 0.5,
                                      ),
                                      SizedBox(height: 9.h),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 24.h),

                  /// --- MANDATORY SUBSCRIPTION DISCLOSURE ---
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      "This is an auto-renewable subscription. Payment will be charged to your iTunes account at confirmation of purchase. The subscription automatically renews unless auto-renew is turned off at least 24 hours before the end of the current billing period. Your account will be charged for renewal within 24 hours prior to the end of the current period at the same price. You can manage your subscription and turn off auto-renewal at any time by going to your Account Settings on the App Store after purchase.",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular12.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  /// --- LEGAL LINKS ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegalLink("Privacy Policy", _privacyPolicyUrl),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "|",
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      _buildLegalLink("Terms of Use", _termsOfUseUrl),
                    ],
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  /// Helper to build legal text links
  Widget _buildLegalLink(String text, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Text(
        text,
        style: AppTextStyles.medium14.copyWith(
          color: AppColors.blackColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // Helper method to format duration text
  String _getDurationText(String duration) {
    switch (duration.toLowerCase()) {
      case 'monthly':
        return 'month';
      case 'weekly':
        return 'week';
      case 'annually':
        return 'year';
      default:
        return duration.toLowerCase();
    }
  }
}
