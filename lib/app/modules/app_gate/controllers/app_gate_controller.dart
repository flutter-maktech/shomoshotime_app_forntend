import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/core/urls/urls.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

class AppGateController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkSubscription();
  }

  Future<void> checkSubscription() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();

      if (token == null || token.isEmpty) {
        Get.offAllNamed(Routes.SIGN_IN);
        return;
      }

      final response = await _networkCaller.postRequest(
        Urls.subscriptionCheck,
        {},
        token: token,
      );

      if (response != null && response['success'] == true) {
        final bool isPremium = response['data']['is_premium'] ?? false;

        if (isPremium) {
          Get.offAllNamed(Routes.CUSTOM_BOTTOM_NAVIGATION_BAR);
        } else {
          Get.offAllNamed(Routes.EXPLORE_PLAN);
        }
      } else {
        errorMessage.value =
            response?['message'] ?? 'Failed to check subscription status';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
