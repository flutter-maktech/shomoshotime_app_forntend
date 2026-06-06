import 'package:get/get.dart';
import '../controllers/session_expired_controller.dart';

class SessionExpiredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionExpiredController>(() => SessionExpiredController());
  }
}
