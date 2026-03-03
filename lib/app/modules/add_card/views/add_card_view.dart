import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../controllers/add_card_controller.dart';
import '../widget/custom_add_card.dart';

class AddCardView extends GetView<AddCardController> {
  const AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Card"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 48.h),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.editProfileTextField,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.h,
                      horizontal: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Text(
                          "Credit/Debit Card",
                          style: AppTextStyles.regular12,
                        ),
                        SizedBox(height: 8.h),
                        CustomAddCard(text: "Credit/Debit Card"),
                        SizedBox(height: 24.h),
                        Text(
                          "Credit/Debit Card",
                          style: AppTextStyles.regular12,
                        ),
                        CustomAddCard(text: "Credit/Debit Card"),
                        SizedBox(height: 24.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expiration Date",
                                    style: AppTextStyles.regular12,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8.h),
                                  CustomAddCard(text: "02/2028"),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("CVV", style: AppTextStyles.regular12),
                                  SizedBox(height: 8.h),
                                  CustomAddCard(text: "02/2028"),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                height: 24.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: AppColors.addCardCheck,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Flexible(
                              flex: 1,
                              child: Text(
                                "Save this card for faster payment",
                                style: AppTextStyles.regular16,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.h,),
                CustomButton(
                  childText: "Pay Now",
                  buttonColor: AppColors.profileYellow,
                  onTap: () => Get.toNamed(Routes.customBottomNavigationBar),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
