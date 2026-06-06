import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/payment_methods_controller.dart';
import '../widget/custom_bank_card.dart';

class PaymentMethodsView extends GetView<PaymentMethodsController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Payment Methods"),
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
                ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CustomBankCard(
                    imagePath: ImagePath.paymentLogoMastercard,
                    bankName: "Axis Bank",
                    lastDigits: "1234",
                    value: 1,
                    controller: controller,
                  ),
                ),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.addCard),
                  child: Container(
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            child: const Icon(Icons.add),
                          ),
                          SizedBox(width: 8.w),
                          Text("Add Card", style: AppTextStyles.regular16),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  childText: "Check out",
                  buttonColor: AppColors.profileYellow,
                  onTap: () => Get.toNamed(Routes.addCard),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
