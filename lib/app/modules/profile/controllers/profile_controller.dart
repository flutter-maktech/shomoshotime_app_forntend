import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/user_panel_model/profile_response.dart';

import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/firebase_services.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final NetworkCaller _networkCaller = NetworkCaller();
  final Rx<ProfileResponse?> profileResponse = Rx<ProfileResponse?>(null);
  final RxString currentPlanName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();
      final plan = await AppPreference.getCurrentPlan();
      currentPlanName.value = plan ?? 'N/A';

      // Use POST request with empty body since API only supports POST
      final response = await _networkCaller.postRequest(
        Urls.userProfile,
        {}, // Empty body
        token: token,
      );

      // Parse the response
      profileResponse.value = ProfileResponse.fromJson(response);
    } catch (e) {
      errorMessage.value = 'Failed to load study guides: $e';
    } finally {
      isLoading.value = false;
    }
  }

  String formatToMonthYear(String? dateString) {
    try {
      // Input: 14 Jan, 2026 08:42 AM
      final DateTime date = DateFormat(
        'dd MMM, yyyy hh:mm a',
      ).parse(dateString ?? '14 Jan, 2026 08:42 AM');

      // Output: January 2026
      return DateFormat('MMMM yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      await FirebaseAuthService().signOut();
      await AppPreference.clearAll();

      Get.offAllNamed(Routes.signIn);
    } catch (e) {
      errorMessage.value = 'Logout failed: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
