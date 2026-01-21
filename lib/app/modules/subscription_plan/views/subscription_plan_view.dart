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
      appBar: CustomAppBar(
        title: "Subscription Plan",
        subTitle: "Update your plan",
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Obx(() {
            // 🔄 Loading
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
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
                  final bool isSelected =
                      controller.selectedValue.value == subscription.id;

                  return Column(
                    children: [
                      if (index == 0) // First item (presumably Weekly)
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.subscriptionPlanSelectedPlan,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                              horizontal: 24.w,
                            ),
                            child: Text(
                              "Your Selected plan",
                              style: AppTextStyles.regular16,
                            ),
                          ),
                        ),

                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: _getBorderRadius(
                            index,
                            sortedSubscriptions.length,
                          ),
                          color: _getPlanColor(index),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subscription.duration,
                                    style: AppTextStyles.medium20,
                                  ),
                                  Obx(
                                    () => Transform.scale(
                                      scale: 1.6,
                                      child: RadioMenuButton(
                                        style: ButtonStyle(),
                                        value: subscription.id,
                                        groupValue:
                                            controller.selectedValue.value,
                                        onChanged: (value) {
                                          controller.updateSelection(value!);
                                        },
                                        child: Text(""),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 7.h),
                              CustomDolarPlan(
                                Dolartext: "\$${subscription.price}",
                                Daytext:
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
                                  style: AppTextStyles.light16,
                                ),
                              if (index == 2)
                                Text(
                                  "Save 17% compared to monthly",
                                  style: AppTextStyles.light16,
                                ),
                              SizedBox(height: 24.h),
                              // Display features from API
                              ...subscription.features.map((feature) {
                                return Column(
                                  children: [
                                    SelectedPlanActivity(text: feature),
                                    SizedBox(height: 9.h),
                                  ],
                                );
                              }).toList(),
                              if (index == 1) // Monthly plan (Most Popular)
                                Column(
                                  children: [
                                    SizedBox(height: 24.h),
                                    Container(
                                      height: 35.h,
                                      width: 124.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors
                                            .subscriptionPlanMostPapular,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Most Popular",
                                          style: AppTextStyles.regular14
                                              .copyWith(
                                                color: AppColors.whiteColor,
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24.h),
                                  ],
                                ),
                              CustomButton(
                                childText: "Get Started",
                                buttonChildColor: AppColors.whiteColor,
                                buttonColor: AppColors.blackColor,
                                onTap: () {
                                  controller.makeSimplePayment(
                                    subscription.price.toDouble(),
                                    context,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (index < sortedSubscriptions.length - 1)
                        SizedBox(height: 24.h),
                    ],
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Helper method to get border radius based on index
  BorderRadius _getBorderRadius(int index, int totalItems) {
    if (index == 0) {
      return BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return BorderRadius.circular(8);
  }

  // Helper method to get plan color based on index
  Color _getPlanColor(int index) {
    switch (index) {
      case 0:
        return AppColors.subscriptionPlanWeekly;
      case 1:
        return AppColors.subscriptionPlanMonthly;
      case 2:
        return AppColors.subscriptionPlanAnnually;
      default:
        return AppColors.subscriptionPlanWeekly;
    }
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
