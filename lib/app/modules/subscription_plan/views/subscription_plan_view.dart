import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/subscription_plan_controller.dart';
import '../widget/custom_dolar_plan.dart';
import '../widget/selected_plan_activity.dart';

class SubscriptionPlanView extends GetView<SubscriptionPlanController> {
  const SubscriptionPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //CustomAppBar
      appBar: CustomAppBar(
        title: "MemberShip Plan",
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
                children: List.generate(sortedSubscriptions.length, (index) {
                  final subscription = sortedSubscriptions[index];
                  final isCurrentPlan =
                      subscription.duration.toLowerCase() ==
                      controller.currentPlanName.value.toLowerCase();

                  return Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      color: index.isEven ? Color(0xffC7C7C7) : Colors.black,
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
                                    subscription.duration,
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
                                    ? "Cancel Plan"
                                    : "Get Started",
                                buttonChildColor: index.isEven
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                                buttonColor: index.isEven
                                    ? AppColors.blackColor
                                    : AppColors.whiteColor,
                                onTap: () {
                                  // 1️⃣ If this is current plan → Cancel
                                  if (isCurrentPlan) {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          backgroundColor: AppColors.whiteColor,
                                          title: Text(
                                            "Cancel Subscription",
                                            style: AppTextStyles.medium20,
                                          ),
                                          content: Text(
                                            "Are you sure you want to cancel your subscription? You will no longer have to access to the premium features.",
                                            style: AppTextStyles.light16,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(
                                                "Cancel",
                                                style: AppTextStyles.medium16
                                                    .apply(
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                controller.cancelSubscription();
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Confirm",
                                                style: AppTextStyles.medium16
                                                    .apply(
                                                      color:
                                                          AppColors.readColor,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
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
                                          backgroundColor: AppColors.whiteColor,
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
                                  controller.makeSimplePayment(
                                    subscription.price.toDouble(),
                                    subscription.id,
                                    context,
                                  );
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
                                ? Color(0xffe8e6e6)
                                : Color(0xffe5cf87),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              children: subscription.features.map((feature) {
                                return Column(
                                  children: [
                                    SelectedPlanActivity(text: feature),
                                    Divider(
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
              ),
            );
          }),
        ),
      ),
    );
  }

  // Helper method to format duration text
  String _getDurationText(String duration) {
    switch (duration.toLowerCase()) {
      case 'weekly':
        return 'Every week';
      case 'monthly':
        return 'Every month';
      case 'annually':
        return 'Every year';
      default:
        return 'Every ${duration.toLowerCase()}';
    }
  }
}
