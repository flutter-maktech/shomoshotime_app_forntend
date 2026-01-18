import 'package:get/get.dart';
import 'package:shomoshotime/app/core/urls/urls.dart' show Urls;
import 'package:shomoshotime/app/core/user_panel_model/user_analytics_response.dart';
import 'package:shomoshotime/app/modules/practice/controllers/practice_controller.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/user_panel_model/question_set_response.dart';

class MockExamsController extends GetxController {
  final practiceController = Get.find<PracticeController>();
  RxBool isloading = false.obs;
  RxString errorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMockTestData();
  }

  NetworkCaller networkCaller = NetworkCaller();
  final Rx<QuestionSetResponse?> questionSetResponse = Rx<QuestionSetResponse?>(
    null,
  );
  List<QuestionSetData> get questionSets =>
      questionSetResponse.value?.data ?? [];

  List<UserAnalyticsData> get mockTestAnalytics =>
      practiceController.userAnalyticsData;

  Future<void> fetchMockTestData() async {
    isloading.value = true;
    errorText.value = '';
    try {
      final body = {"current_mode": "mock_test"};

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.praciceQuesionSet,
        body,
        token: token,
      );
      questionSetResponse.value = QuestionSetResponse.fromJson(response);
    } catch (e) {
      print('------$e');
      errorText.value = 'An eeeerror occurred: $e';
    } finally {
      isloading.value = false;
    }
  }

  Future<void> startMockTest(int id) async {
    isloading.value = true;
    errorText.value = '';
    try {
      final body = {"question_set_id": id};

      final token = await AppPreference.getToken();

       await networkCaller.postRequest(
        Urls.startMockTest,
        body,
        token: token,
      );
    } catch (e) {
      errorText.value = 'An eeeerror occurred: $e';
      print('----------------$e');
    } finally {
      isloading.value = false;
    }
  }

  var selectIndex = 0.obs;
  void changeIndex(int index) {
    selectIndex.value = index;
  }
}
