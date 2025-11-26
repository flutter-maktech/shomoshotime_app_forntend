import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import '../controllers/payment_methods_controller.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Payment Methods"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        ImagePath.paymentCreditCard,
                        height: 32.h,
                        width: 32.w,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "Credit/Debit Card",
                        style: AppTextStyles.regular20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.paymentMethods),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(flex: 1,
                          child: Image.asset(
                            ImagePath.paymentLogoMastercard,
                            height: 24.h,
                            width: 31.w,
                          ),
                        ),
                        Flexible(flex: 3,
                          child: Text(
                            "Axis Bank  **** 1234",
                            style: AppTextStyles.regular16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Obx(
                          () => Transform.scale(
                            scale: 1.6,
                            child: Flexible(flex: 1,
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
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.paymentMethods),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(flex: 1,
                          child: Image.asset(
                            ImagePath.paymentLogoVisa,
                            height: 16.h,
                            width: 50.w,
                          ),
                        ),
                        Flexible(flex: 3,
                          child: Text(
                            "Axis Bank  **** 1234",
                            style: AppTextStyles.regular16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Obx(
                          () => Transform.scale(
                            scale: 1.6,
                            child: Flexible(flex: 1,
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
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.editProfileTextField,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                          ),
                          child: Icon(Icons.add),
                        ),
                        SizedBox(width: 8.w),
                        Text("Add Card", style: AppTextStyles.regular16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 320.h),
                CustomButton(
                  childText: "Check out",
                  buttonColor: AppColors.profileYellow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
