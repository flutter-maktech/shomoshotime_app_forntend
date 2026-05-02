import 'package:get/get.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/user_panel_model/question_list_response_model.dart';

class AnswerHistory {
  final int selectedIndex;
  final bool isCorrectAnswer;
  final int correctIndex;

  AnswerHistory({
    required this.selectedIndex,
    required this.isCorrectAnswer,
    required this.correctIndex,
  });
}

class SpiPracticeBankQusController extends GetxController {
  RxBool isloading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxString errorText = ''.obs;
  RxString selectedAnswer = ''.obs;
  RxInt correctIndex = (-1).obs;
  RxInt currentQuestionIndex = 0.obs;
  RxBool showResult = false.obs;
  RxBool isCorrectAnswer = false.obs;
  RxBool isFinished = false.obs;

  // Pagination variables
  int currentPage = 1;
  int lastPage = 1;
  RxInt totalQuestionsCount = 0.obs;
  final allQuestions = <QuestionData>[].obs;

  // Store answer history by question index
  final RxMap<int, AnswerHistory> answerHistories = <int, AnswerHistory>{}.obs;

  NetworkCaller networkCaller = NetworkCaller();
  final Rx<QuestionListResponse?> questionListResponse =
      Rx<QuestionListResponse?>(null);
  @override
  void onInit() {
    super.onInit();
    // Set totalQuestionsCount from arguments if available
    if (Get.arguments != null && Get.arguments['totalQuestions'] != null) {
      totalQuestionsCount.value = Get.arguments['totalQuestions'];
    }
    fetchQuestionList();
  }

  Future<void> fetchQuestionList({int page = 1}) async {
    if (page == 1) {
      isloading.value = true;
      allQuestions.clear();
    } else {
      isLoadingMore.value = true;
    }
    errorText.value = '';
    try {
      final args = Get.arguments as Map<String, dynamic>?;
      final int id = args != null && args['id'] != null ? args['id'] : 0;
      final body = {"question_set_id": id, "page": page.toString()};

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.praciceQuesion,
        body,
        token: token,
      );
      final newResponse = QuestionListResponse.fromJson(response);
      questionListResponse.value = newResponse;

      if (newResponse.success) {
        allQuestions.addAll(newResponse.data);

        currentPage = newResponse.meta.currentPage;
        lastPage = newResponse.meta.lastPage;
        totalQuestionsCount.value = newResponse.meta.total;

        // Restore progress
        if (page == 1 && allQuestions.isNotEmpty) {
          final savedIndex = await AppPreference.getQuestionProgress(id);
          if (savedIndex > 0) {
            // If saved index is beyond currently loaded cards, we might need to load more
            if (savedIndex < allQuestions.length) {
              currentQuestionIndex.value = savedIndex;
            } else {
              // For simplicity, let's just start at 0 if it's not loaded
              // or we could recursively fetch more pages...
            }
          }
        }
      }
    } catch (e) {
      errorText.value = 'An error occurred: $e';
    } finally {
      isloading.value = false;
      isLoadingMore.value = false;
    }
  }

  List<QuestionData> get questionList => allQuestions;

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

      final Map<int, String> answerMap = {
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

      // ------------------------------
      // HANDLE RESPONSE DATA
      // ------------------------------

      // Example API response:
      // {
      //   "data": {
      //     "is_correct": false,
      //     "correct_answer": "option_c"
      //   }
      // }

      isCorrectAnswer.value = response['data']['is_correct'];

      final String correctAnswer = response['data']['correct_answer'];

      final Map<String, int> reverseAnswerMap = {
        'option_a': 0,
        'option_b': 1,
        'option_c': 2,
        'option_d': 3,
      };

      correctIndex.value = reverseAnswerMap[correctAnswer] ?? -1;

      showResult.value = true;

      answerHistories[currentQuestionIndex.value] = AnswerHistory(
        selectedIndex: selectedIndex.value,
        isCorrectAnswer: isCorrectAnswer.value,
        correctIndex: correctIndex.value,
      );

      // ------------------------------
      // CHECK IF LAST QUESTION
      // ------------------------------
      if (currentQuestionIndex.value == totalQuestionsCount.value - 1) {
        isFinished.value = true;
        // Reset progress on completion
        final args = Get.arguments as Map<String, dynamic>?;
        final int questionSetId = args?['id'] ?? 0;
        if (questionSetId != 0) {
          AppPreference.saveQuestionProgress(questionSetId, 0);
        }
      }
    } catch (e) {
      errorText.value = e.toString();
    } finally {
      isloading.value = false;
    }
  }

  void goToNextQuestion() {
    // Only move to next question if there are more
    if (currentQuestionIndex.value < totalQuestionsCount.value - 1) {
      currentQuestionIndex.value++;

      _restoreQuestionState();

      // Load more if we reached the end of loaded questions
      if (currentQuestionIndex.value >= allQuestions.length &&
          currentPage < lastPage &&
          !isLoadingMore.value) {
        fetchQuestionList(page: currentPage + 1);
      }

      // Save progress
      final args = Get.arguments as Map<String, dynamic>?;
      final int questionSetId = args?['id'] ?? 0;
      if (questionSetId != 0) {
        AppPreference.saveQuestionProgress(
          questionSetId,
          currentQuestionIndex.value,
        );
      }
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      _restoreQuestionState();
    }
  }

  void _restoreQuestionState() {
    if (answerHistories.containsKey(currentQuestionIndex.value)) {
      final history = answerHistories[currentQuestionIndex.value]!;
      selectedIndex.value = history.selectedIndex;
      isCorrectAnswer.value = history.isCorrectAnswer;
      correctIndex.value = history.correctIndex;
      showResult.value = true;
    } else {
      selectedIndex.value = -1;
      showResult.value = false;
      isCorrectAnswer.value = false;
      correctIndex.value = -1;
    }

    if (currentQuestionIndex.value == totalQuestionsCount.value - 1 && showResult.value) {
      isFinished.value = true;
    } else {
      isFinished.value = false;
    }
  }
}
