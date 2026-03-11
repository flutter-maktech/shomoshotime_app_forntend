import 'package:get/get.dart';
import '../../../all_utils/app_preference.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  // Don't initialize here if it's async
  String? token;

  @override
  void onReady() {
    super.onReady();
    showSplash();
  }

  void showSplash() async {
    // Get token asynchronously
    token = await AppPreference.getToken();

    Future.delayed(const Duration(seconds: 1), () {
      if (token != null && token!.isNotEmpty) {
        // If token exists, go to App Gate to check premium status
        Get.offAllNamed(Routes.appGate);
      } else {
        // If no token, go to login screen
        Get.offAllNamed(Routes.signIn); // Replace with your login route
      }
    });
  }
}
