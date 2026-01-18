import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shomoshotime/key.dart';

import '../../../routes/app_pages.dart';

class SubscriptionPlanController extends GetxController {
  RxInt selectedValue = 1.obs;
  Map<String, dynamic>? paymentIntentData;
  RxBool isLoading = false.obs;

  void updateSelection(int value) {
    selectedValue.value = value;
  }

  // Main payment handler
  Future<void> handlePayment(double amount, String currency) async {
    try {
      isLoading.value = true;
      
      // Create payment intent
      await createPaymentIntent(amount.toString(), currency);
      
      // Initialize payment sheet
      await initializePaymentSheet();
      
      // Display payment sheet
      await displayPaymentSheet();
      
    } catch (error) {
      if (kDebugMode) {
        print('Payment Error: $error');
      }
      _showSnackbar('Error', 'Payment failed: ${error.toString()}', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Create payment intent on Stripe
  Future<void> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (double.parse(amount) * 100).toStringAsFixed(0),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        paymentIntentData = jsonDecode(response.body);
        if (kDebugMode) {
          print('Payment Intent Created: $paymentIntentData');
        }
      } else {
        throw Exception('Failed to create payment intent: ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Initialize the payment sheet (without Apple Pay for now)
  Future<void> initializePaymentSheet() async {
    try {
      if (paymentIntentData == null || paymentIntentData!['client_secret'] == null) {
        throw Exception('Payment intent not created properly');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Shomoshotime',
          // Comment out Apple Pay for now if you don't have merchant identifier
          // applePay: const PaymentSheetApplePay(
          //   merchantCountryCode: 'US',
          // ),
          // Enable Google Pay only if configured
          // googlePay: const PaymentSheetGooglePay(
          //   merchantCountryCode: 'US',
          //   currencyCode: 'USD',
          //   testEnv: true,
          // ),
          customFlow: false,
          customerId: paymentIntentData?['customer'],
          customerEphemeralKeySecret: paymentIntentData?['ephemeralKey'],
          // setupFutureUsage: null,
        ),
      );
      
      if (kDebugMode) {
        print('Payment sheet initialized successfully');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Display the payment sheet
  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      
      // Payment successful
      if (kDebugMode) {
        print('Payment successful!');
      }
      
      // Navigate to success page or next screen
      Get.offNamed(Routes.PAYMENT_METHODS);
      
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Stripe Exception: ${e.error.localizedMessage}');
      }
      
      // Show error dialog
      Get.dialog(
        AlertDialog(
          title: Text('Payment Error'),
          content: Text(e.error.localizedMessage ?? 'Payment cancelled'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      
      Get.dialog(
        AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Helper method to show snackbar with proper context
  void _showSnackbar(String title, String message, {bool isError = false}) {
    Get.closeAllSnackbars(); // Close any existing snackbars
    
    // Use a small delay to ensure proper context
    Future.delayed(Duration(milliseconds: 100), () {
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: isError ? Colors.red : Colors.green,
        colorText: Colors.white,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
        duration: Duration(seconds: 3),
      );
    });
  }

  // Alternative simplified payment method
  Future<void> makeSimplePayment(double amount) async {
    try {
      isLoading.value = true;
      
      // Create payment intent
      await createPaymentIntent(amount.toString(), 'usd');
      
      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          merchantDisplayName: 'Shomoshotime',
          customerId: paymentIntentData?['customer'],
        ),
      );
      
      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();
      
      // Success
      _showSnackbar('Success', 'Payment of \$$amount completed!');
      
      // Navigate to next screen
      Get.offNamed(Routes.PAYMENT_METHODS);
      
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.error.localizedMessage}');
      }
      _showSnackbar('Payment Failed', e.error.localizedMessage ?? 'Payment cancelled', isError: true);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      _showSnackbar('Error', 'Something went wrong: $e', isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}