import 'package:get/get.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/user_panel_model/question_list_response_model.dart';

class SpiPracticeBankQusController extends GetxController {
  RxBool isloading = false.obs;
  RxString errorText = ''.obs;
  RxString selectedAnswer = ''.obs;
  RxInt currentQuestionIndex = 0.obs;
  RxBool showResult = false.obs;
  RxBool isCorrectAnswer = false.obs;
  RxBool isFinished = false.obs;

  NetworkCaller networkCaller = NetworkCaller();
  final Rx<QuestionListResponse?> questionListResponse =
      Rx<QuestionListResponse?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchQuestionList();
  }

  Future<void> fetchQuestionList() async {
    isloading.value = true;
    errorText.value = '';
    try {
      final args = Get.arguments as Map<String, dynamic>?;
      final int id = args != null && args['id'] != null ? args['id'] : 0;
      final body = {"question_set_id": id};

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.praciceQuesion,
        body,
        token: token,
      );
      questionListResponse.value = QuestionListResponse.fromJson(response);
    } catch (e) {
      errorText.value = 'An error occurred: $e';
    } finally {
      isloading.value = false;
    }
  }

  List<QuestionData> get questionList => questionListResponse.value?.data ?? [];

  RxInt selectedIndex = (-1).obs;

  void selectOption(int index) {
    selectedIndex.value = index;
  }

  Future<void> submitAnswer() async {
    if (selectedIndex.value == -1) return;

    try {
      isloading.value = true;

      final args = Get.arguments as Map<String, dynamic>?;
      final int questionSetId = args?['id'] ?? 0;

      final question = questionList[currentQuestionIndex.value];
      final token = await AppPreference.getToken();

      final answerMap = {
        0: 'option_a',
        1: 'option_b',
        2: 'option_c',
        3: 'option_d',
      };

      final body = {
        "question_set_id": questionSetId.toString(),
        "question_id": question.id.toString(),
        "answer": answerMap[selectedIndex.value],
      };

      final response = await networkCaller.postRequest(
        Urls.answerSubmit,
        body,
        token: token,
      );

      isCorrectAnswer.value = response['data']['is_correct'];
      showResult.value = true;

      // Check if this is the last question
      if (currentQuestionIndex.value == questionList.length - 1) {
        isFinished.value = true;
      }
    } catch (e) {
      errorText.value = e.toString();
    } finally {
      isloading.value = false;
    }
  }

  void goToNextQuestion() {
    // Only move to next question if there are more
    if (currentQuestionIndex.value < questionList.length - 1) {
      currentQuestionIndex.value++;
      selectedIndex.value = -1;
      showResult.value = false;
    }
  }
}
