import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';

import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/user_panel_model/study_guide_response_model.dart';

class HomeController extends GetxController {
  final NetworkCaller _networkCaller = NetworkCaller();

  // Rx variables for state management
  final Rx<StudyGuideResponse?> studyGuideResponse = Rx<StudyGuideResponse?>(
    null,
  );
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStudyGuides();
  }

  // Fetch study guides
  Future<void> fetchStudyGuides() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();
      print('$token -----');

      final response = await _networkCaller.getRequest(
        Urls.studyGuideList,
        token: token,
      );

      // Parse the response
      studyGuideResponse.value = StudyGuideResponse.fromJson(response);
    } catch (e) {
      errorMessage.value = 'Failed to load study guides: $e';
      print('Error fetching study guides: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get study guides list (convenience getter)
  List<StudyGuide> get studyGuides => studyGuideResponse.value?.data ?? [];

  // Refresh data
  Future<void> refreshData() async {
    await fetchStudyGuides();
  }
}
