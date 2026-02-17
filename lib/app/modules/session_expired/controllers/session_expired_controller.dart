import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

class SessionExpiredController extends GetxController {
  Future<void> logoutAndRedirect() async {
    await AppPreference.clearAll();
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
