import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shomoshotime/key.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../routes/app_pages.dart';

class SubscriptionPlanController extends GetxController {
  RxInt selectedValue = 1.obs;
  Map<String, dynamic>? paymentIntentData;
  RxBool isLoading = false.obs;

  // Store the BuildContext from the view
  BuildContext? _context;

  // Method to set context from the view
  void setContext(BuildContext context) {
    _context = context;
  }

  void updateSelection(int value) {
    selectedValue.value = value;
  }

  // Main payment handler
  Future<void> handlePayment(double amount, String currency, BuildContext context) async {
    setContext(context); // Store the context
    try {
      isLoading.value = true;
      
      // Create payment intent
      await createPaymentIntent(amount.toString(), currency);
      
      // Initialize payment sheet
      await initializePaymentSheet();
      
      // Display payment sheet
      await displayPaymentSheet(context);
      
    } catch (error) {
      if (kDebugMode) {
        print('Payment Error: $error');
      }
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message: 'Payment failed: ${error.toString()}',
          backgroundColor: Colors.red,
        );
      }
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

  // Initialize the payment sheet - SIMPLIFIED VERSION
  Future<void> initializePaymentSheet() async {
    try {
      if (paymentIntentData == null || paymentIntentData!['client_secret'] == null) {
        throw Exception('Payment intent not created properly');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          merchantDisplayName: 'Shomoshotime',
          // Minimal configuration to avoid errors
          customFlow: false,
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
  Future<void> displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      
      // Payment successful
      if (kDebugMode) {
        print('Payment successful!');
      }
      
      // Show success snackbar
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message: 'Payment completed successfully!',
          backgroundColor: Colors.green,
        );
      }
      
      // Navigate to success page or next screen
      Get.offNamed(Routes.PAYMENT_METHODS);
      
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Stripe Exception: ${e.error.localizedMessage}');
      }
      
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Error'),
          content: Text(e.error.localizedMessage ?? 'Payment cancelled'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      
    } catch (error) {
      if (kDebugMode) {
        print('General Error: $error');
      }
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  // Alternative simplified payment method
  Future<void> makeSimplePayment(double amount, BuildContext context) async {
    setContext(context); // Store the context
    
    try {
      isLoading.value = true;
      
      // Create payment intent
      await createPaymentIntent(amount.toString(), 'usd');
      
      // Initialize payment sheet - ULTRA SIMPLE
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          merchantDisplayName: 'Shomoshotime',
        ),
      );
      
      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();
      
      // Success
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message: 'Payment of \$$amount completed!',
          backgroundColor: Colors.green,
        );
      }
      
      // Navigate to next screen
      Get.offNamed(Routes.PAYMENT_METHODS);
      
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.error.localizedMessage}');
      }
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message: 'Payment Failed: ${e.error.localizedMessage ?? "Payment cancelled"}',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message: 'Something went wrong: $e',
          backgroundColor: Colors.red,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Ultra simple test method for debugging
  Future<void> makeTestPayment(double amount, BuildContext context) async {
    try {
      isLoading.value = true;
      
      // 1. Create payment intent with minimal data
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': '1000', // $10.00 in cents for testing
          'currency': 'usd',
          'payment_method_types[]': 'card',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create payment intent');
      }

      final paymentIntent = json.decode(response.body);
      
      // 2. Initialize with absolute minimum configuration
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Shomoshotime',
        ),
      );
      
      // 3. Present payment sheet
      await Stripe.instance.presentPaymentSheet();
      
      // 4. Show success
      showAppSnackBar(
        context: context,
        message: 'Payment successful!',
        backgroundColor: Colors.green,
      );
      
      // 5. Navigate
      Get.offNamed(Routes.PAYMENT_METHODS);
      
    } on StripeException catch (e) {
      showAppSnackBar(
        context: context,
        message: 'Payment failed: ${e.error.localizedMessage ?? "Unknown error"}',
        backgroundColor: Colors.red,
      );
    } catch (e) {
      showAppSnackBar(
        context: context,
        message: 'Error: $e',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}