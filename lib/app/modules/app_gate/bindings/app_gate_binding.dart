import 'package:get/get.dart';
import '../controllers/app_gate_controller.dart';

class AppGateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppGateController>(() => AppGateController());
  }
}
