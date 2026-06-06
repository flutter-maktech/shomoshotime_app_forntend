import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/payment_methods_controller.dart';

class CustomBankCard extends StatelessWidget {
  final String imagePath;
  final String bankName;
  final String lastDigits;
  final int value;
  final PaymentMethodsController controller;

  const CustomBankCard({
    super.key,
    required this.imagePath,
    required this.bankName,
    required this.lastDigits,
    required this.value,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.paymentMethods),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          /// Bank Logo
          Image.asset(
            imagePath,
            height: 28.h,
            width: 32.w,
            fit: BoxFit.contain,
          ),

          SizedBox(width: 12.w),

          /// Bank Info
          Expanded(
            child: Text(
              "$bankName  **** $lastDigits",
              style: AppTextStyles.regular16,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          /// Radio
          Obx(
                () => Transform.scale(
              scale: 1.4,
              child: Radio<int>(
                value: value,
                
                groupValue: controller.selectedValue.value,
                onChanged: (v) {
                  controller.updateSelection(v!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}