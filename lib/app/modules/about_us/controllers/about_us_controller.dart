import 'dart:convert';
import 'package:get/get.dart';
import '../../../all_utils/app_preference.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../core/urls/urls.dart';
import '../../../core/user_panel_model/cms_response.dart';

class AboutUsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<CmsResponse?> cmsResponse = Rx<CmsResponse?>(null);
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void onInit() {
    super.onInit();
    fetchCmsData(Urls.cmsUrl, "about_us");
  }

  Future<void> fetchCmsData(String url, String type) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();

      final response = await _networkCaller.postRequest(url, {
        "type": type,
      }, token: token);

      cmsResponse.value = CmsResponse.fromJson(response);
    } catch (e) {
      errorMessage.value = 'Failed to load $type content: $e';
    } finally {
      isLoading.value = false;
    }
  }

  /// Extracts plain text from Quill Delta JSON string
  String getPlainText(String? deltaString) {
    if (deltaString == null || deltaString.isEmpty) return "";
    try {
      final List<dynamic> delta = jsonDecode(deltaString);
      String plainText = "";
      for (var op in delta) {
        if (op is Map && op.containsKey('insert')) {
          plainText += op['insert'].toString();
        }
      }
      return plainText;
    } catch (e) {
      // If it's not a valid JSON delta, return the original string
      return deltaString;
    }
  }
}
