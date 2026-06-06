import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../all_utils/log.dart';
import '../../../core/urls/urls.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/user_panel_model/subscription_model.dart';
import '../../../routes/app_pages.dart';

class SubscriptionPlanController extends GetxController {
  RxInt selectedValue = 1.obs;
  RxBool isLoading = false.obs;
  final errorMessage = ''.obs;
  final NetworkCaller networkCaller = NetworkCaller();
  final subscriptions = <Subscription>[].obs;
  static bool _isRevenueCatInitialized = false;

  // RevenueCat offerings
  final offerings = Rxn<Offerings>();
  RxString currentPlanName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    await initPlatformState(); // ✅ wait until configured
    await fetchSubscriptionPlans(); // ✅ safe now
    await _loadCurrentPlan();
  }

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.debug);

    if (_isRevenueCatInitialized) return;

    PurchasesConfiguration? configuration;

    if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(
        "goog_YBgebgxKnmCSpIktDFrZxEgAIYG",
      );
    } else if (Platform.isIOS) {
      configuration = PurchasesConfiguration(
        "appl_zhFlCcmajBDpMYOSpjhKClrjzaj",
      );
    }

    if (configuration != null) {
      await Purchases.configure(configuration);
      _setupCustomerInfoListener();
      _isRevenueCatInitialized = true; // ✅ mark initialized
    }
  }

  void _setupCustomerInfoListener() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      // We no longer rely on RevenueCat to update subscription status.
      // Logic shifted to rely on backend subscription-check API response.
    });
  }

  Future<void> _loadCurrentPlan() async {
    try {
      final token = await AppPreference.getToken();
      if (token != null && token.isNotEmpty) {
        final response = await networkCaller.postRequest(
          Urls.subscriptionCheck,
          {},
          token: token,
        );

        if (response != null && response['success'] == true) {
          final data = response['data'];
          final bool isPremium = data['is_premium'] ?? false;

          if (isPremium) {
            final plans = data['plans'];
            if (plans != null && plans['current'] != null) {
              final currentPlan = plans['current']['name'];
              if (currentPlan != null) {
                currentPlanName.value = currentPlan;
                AppPreference.saveCurrentPlan(currentPlan);
                return;
              }
            }
          } else {
            currentPlanName.value = '';
            AppPreference.clearCurrentPlan();
            return;
          }
        }
      }
    } catch (e) {
      AppLogger.log('Error checking subscription: $e');
    }

    // Fallback to local preference
    final plan = await AppPreference.getCurrentPlan();
    if (plan != null) {
      currentPlanName.value = plan;
    }
  }

  Future<void> fetchSubscriptionPlans() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Fetch from RevenueCat
      try {
        offerings.value = await Purchases.getOfferings();
      } catch (e) {
        AppLogger.log('Error fetching offerings: $e');
      }

      // Fetch from backend
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
      errorMessage.value = 'Something went wrong: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void updateSelection(int value) {
    selectedValue.value = value;
  }

  Package? getPackageForSubscription(String duration) {
    if (offerings.value == null) {
      AppLogger.log('❌ Offerings is null');
      return null;
    }

    // Use current offering if available, otherwise look through all offerings
    List<Package> availablePackages = [];
    if (offerings.value!.current != null) {
      availablePackages = offerings.value!.current!.availablePackages;
    } else if (offerings.value!.all.isNotEmpty) {
      AppLogger.log(
        '⚠️ Current offering is null, checking all offerings as fallback',
      );
      for (var offering in offerings.value!.all.values) {
        availablePackages.addAll(offering.availablePackages);
      }
    }

    if (availablePackages.isEmpty) {
      AppLogger.log('❌ No packages available in any offering');
      return null;
    }

    AppLogger.log('🔍 Matching duration: "$duration"');
    String search = duration.toLowerCase().trim();

    // Normalize common duration strings
    if (search.contains('annual')) {
      search = 'annual';
    } else if (search.contains('yearly')) {
      search = 'annual';
    } else if (search.contains('month')) {
      search = 'monthly';
    } else if (search.contains('week')) {
      search = 'weekly';
    }

    for (var package in availablePackages) {
      String packageTypeStr = package.packageType.toString().toLowerCase();
      String packageId = package.identifier.toLowerCase();

      // Strict matching for package type first
      if (packageTypeStr == 'packagetype.$search' ||
          packageTypeStr.endsWith('.$search')) {
        return package;
      }

      // Fallback to identifier matching
      if (packageId.contains(search)) {
        return package;
      }

      // Special cases for annual/yearly
      if (search == 'annual' &&
          (packageTypeStr.contains('yearly') || packageId.contains('yearly'))) {
        return package;
      }
    }
    return null;
  }

  Future<void> purchasePlan(Package package, int subscriptionId) async {
    try {
      isLoading.value = true;
      // Using the latest purchase method
      CustomerInfo customerInfo = (await Purchases.purchase(
        PurchaseParams.package(package),
      )).customerInfo;

      if (customerInfo.entitlements.active.isNotEmpty) {
        final amount = package.storeProduct.price;
        await storePaymentInfo(subscriptionId, amount);

        Get.offNamed(Routes.customBottomNavigationBar);
        if (Get.context != null) {
          showAppSnackBar(
            context: Get.context!,
            message: 'Purchase successful!',
            backgroundColor: Colors.green,
          );
        }
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        if (Get.context != null) {
          showAppSnackBar(
            context: Get.context!,
            message: 'Error: ${e.message}',
            backgroundColor: Colors.red,
          );
        }
      }
    } catch (e) {
      if (Get.context != null) {
        showAppSnackBar(
          context: Get.context!,
          message: 'Error: $e',
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
        "amount": amount,
        "payment_method": "revenuecat",
      };

      final response = await networkCaller.postRequest(
        Urls.paymentInfo,
        body,
        token: token,
      );

      if (response['status'] == 'success' || response['success'] == true) {
        String? currentPlan;
        if (response['data'] != null &&
            response['data']['plans'] != null &&
            response['data']['plans']['current'] != null) {
          currentPlan = response['data']['plans']['current']['name'];
          AppLogger.log('✅ $currentPlan');
        }
        if (currentPlan != null) {
          currentPlanName.value = currentPlan;
          AppPreference.saveCurrentPlan(currentPlan);
        }
        if (kDebugMode) {
          AppLogger.log('Payment info stored successfully');
        }
      } else {
        if (kDebugMode) {
          AppLogger.log('Failed to store payment info: ${response['message']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.log('Error storing payment info: $e');
      }
    }
  }

  Future<void> cancelSubscription() async {
    try {
      isLoading.value = true;
      final token = await AppPreference.getToken();
      final response = await networkCaller.postRequest(
        Urls.cancelSubscription,
        {},
        token: token,
      );
      if (response['success'] == true) {
        await AppPreference.clearCurrentPlan();
        currentPlanName.value = '';
        Get.offAllNamed(Routes.explorePlan);
        if (Get.context != null) {
          showAppSnackBar(
            context: Get.context!,
            message: 'Subscription cancelled successfully',
            backgroundColor: Colors.green,
          );
        }
      } else {
        if (Get.context != null) {
          showAppSnackBar(
            context: Get.context!,
            message: 'Failed to cancel subscription: ${response['message']}',
            backgroundColor: Colors.red,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        AppLogger.log('Error cancelling subscription: $e');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
