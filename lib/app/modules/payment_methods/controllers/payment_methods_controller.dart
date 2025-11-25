import 'package:get/get.dart';

class PaymentMethodsController extends GetxController {
  RxInt selectedValue = 1.obs;

  UpdateSelection (int value){
    selectedValue.value = value;

  }
}
