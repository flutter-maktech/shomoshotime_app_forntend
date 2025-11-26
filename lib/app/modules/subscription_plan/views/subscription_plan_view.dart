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
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
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
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    color: AppColors.subscriptionPlanWeekly,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Weekly", style: AppTextStyles.medium20),
                            Obx(
                              () => Transform.scale(
                                scale: 1.6,
                                child: RadioMenuButton(
                                  style: ButtonStyle(),
                                  value: 1,
                                  groupValue: controller.selectedValue.value,
                                  onChanged: (value) {
                                    controller.UpdateSelection(value!);
                                  },
                                  child: Text(""),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7.h),
                        CustomDolarPlan(
                          Dolartext: "\$10",
                          Daytext: '/ Every week',
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          "Perfect for short-term preparation",
                          style: AppTextStyles.light16,
                        ),
                        SizedBox(height: 24.h),
                        SelectedPlanActivity(
                          text: "Full access to all study guides",
                        ),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(text: "Unlimited flashcardS"),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(
                          text: "Practice questions for all specialties",
                        ),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(text: "Cancel anytime"),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(
                          text: "All future updates included",
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          childText: "Get Started",
                          buttonChildColor: AppColors.whiteColor,
                          buttonColor: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.subscriptionPlanMonthly,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Monthly", style: AppTextStyles.medium20),
                            Obx(
                              () => Transform.scale(
                                scale: 1.6,
                                child: RadioMenuButton(
                                  style: ButtonStyle(),
                                  value: 2,
                                  groupValue: controller.selectedValue.value,
                                  onChanged: (value) {
                                    controller.UpdateSelection(value!);
                                  },
                                  child: Text(""),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7.h),
                        CustomDolarPlan(
                          Dolartext: "\$30",
                          Daytext: '/ Every week',
                        ),
                        SizedBox(height: 7.h),
                        Text("Every Month", style: AppTextStyles.light16),
                        SizedBox(height: 24.h),
                        SelectedPlanActivity(
                          text: "Full access to all study guides",
                        ),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(text: "Unlimited flashcardS"),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(
                          text: "Practice questions for all specialties",
                        ),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(text: "Cancel anytime"),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(
                          text: "All future updates included",
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          height: 35.h,
                          width: 124.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.subscriptionPlanMostPapular,
                          ),
                          child: Center(
                            child: Text(
                              "Most Popular",
                              style: AppTextStyles.regular14.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          childText: "Get Started",
                          buttonChildColor: AppColors.whiteColor,
                          buttonColor: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.subscriptionPlanAnnually,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Annually", style: AppTextStyles.medium20),
                            Obx(
                              () => Transform.scale(
                                scale: 1.6,
                                child: RadioMenuButton(
                                  value: 3,
                                  groupValue: controller.selectedValue.value,
                                  onChanged: (value) {
                                    controller.UpdateSelection(value!);
                                  },
                                  child: Text(""),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7.h),
                        CustomDolarPlan(
                          Dolartext: "\$249",
                          Daytext: '/ Every week',
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          "Save 17% compared to monthly",
                          style: AppTextStyles.light16,
                        ),
                        SizedBox(height: 24.h),
                        SelectedPlanActivity(
                          text: "Full access to all study guides",
                        ),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(text: "Unlimited flashcardS"),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(
                          text: "Practice questions for all specialties",
                        ),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(text: "Cancel anytime"),
                        SizedBox(height: 9.h),
                        SelectedPlanActivity(
                          text: "All future updates included",
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          childText: "Get Started",
                          buttonChildColor: AppColors.whiteColor,
                          buttonColor: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
