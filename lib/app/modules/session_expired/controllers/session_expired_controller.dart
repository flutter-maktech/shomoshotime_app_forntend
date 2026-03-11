import 'package:get/get.dart';
import '../../../all_utils/app_preference.dart';
import '../../../routes/app_pages.dart';

class SessionExpiredController extends GetxController {
  Future<void> logoutAndRedirect() async {
    await AppPreference.clearAll();
    Get.offAllNamed(Routes.signIn);
  }
}
