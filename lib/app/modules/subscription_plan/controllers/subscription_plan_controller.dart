import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shomoshotime/app/core/urls/urls.dart';
import 'package:shomoshotime/key.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/user_panel_model/subscription_model.dart';
import '../../../routes/app_pages.dart';

class SubscriptionPlanController extends GetxController {
  RxInt selectedValue = 1.obs;
  Map<String, dynamic>? paymentIntentData;
  RxBool isLoading = false.obs;
  final errorMessage = ''.obs;
  final NetworkCaller networkCaller = NetworkCaller();
  final subscriptions = <Subscription>[].obs;
  @override
  void onInit() {
    super.onInit();
    fetchSubscriptionPlans();
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.subscriptionList,
        {},
        token: token,
      );
      if (response['success'] == true) {
        final subscriptionResponse = SubscriptionResponse.fromJson(response);

        subscriptions.assignAll(subscriptionResponse.data);
      } else {
        errorMessage.value =
            response['message'] ?? 'Failed to load subscriptions';
      }
    } catch (e) {
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading.value = false;
    }
  }

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
  Future<void> handlePayment(
    double amount,
    String currency,
    BuildContext context,
  ) async {
    setContext(context); // Store the context
    try {
      isLoading.value = true;

      // Create payment intent
      await createPaymentIntent(amount.toString(), currency);

      // Initialize payment sheet
      await initializePaymentSheet();

      // Display payment sheet
      await displayPaymentSheet(_context!);
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
        throw Exception(
          'Failed to create payment intent: ${response.statusCode}',
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  // Initialize the payment sheet - SIMPLIFIED VERSION
  Future<void> initializePaymentSheet() async {
    try {
      if (paymentIntentData == null ||
          paymentIntentData!['client_secret'] == null) {
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
      Get.back();
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Stripe Exception: ${e.error.localizedMessage}');
      }

      // Show error dialog
      showDialog(
        context: _context!,
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
        context: _context!,
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
  Future<void> makeSimplePayment(
    double amount,
    int subscriptionId,
    BuildContext context,
  ) async {
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

      // Store Payment Info
      await storePaymentInfo(subscriptionId, amount);

      // Success
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message: 'Payment of \$$amount completed!',
          backgroundColor: Colors.green,
        );
      }

      // Navigate to next screen
      Get.offNamed(Routes.CUSTOM_BOTTOM_NAVIGATION_BAR);
    } on StripeException catch (e) {
      if (kDebugMode) {
        print('Error: ${e.error.localizedMessage}');
      }
      if (_context != null) {
        showAppSnackBar(
          context: _context!,
          message:
              'Payment Failed: ${e.error.localizedMessage ?? "Payment cancelled"}',
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

  Future<void> storePaymentInfo(int subscriptionId, double amount) async {
    try {
      final userId = await AppPreference.getUserId();
      final token = await AppPreference.getToken();

      Map<String, dynamic> body = {
        "user_id": userId,
        "subscription_id": subscriptionId,
        "payment_intent_data": jsonEncode(paymentIntentData),
        "amount": amount,
      };

      final response = await networkCaller.postRequest(
        Urls.paymentInfo,
        body,
        token: token,
      );

      if (response['status'] == 'success' || response['success'] == true) {
        if (kDebugMode) {
          print('Payment info stored successfully');
        }
      } else {
        if (kDebugMode) {
          print('Failed to store payment info: ${response['message']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error storing payment info: $e');
      }
    }
  }
}
