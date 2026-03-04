import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/core/urls/urls.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final NetworkCaller networkCaller = NetworkCaller();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorText = ''.obs;

  /// Pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<bool> updateProfile() async {
  try {
    isLoading.value = true;

    final token = await AppPreference.getToken();

    final Map<String, String> fields = {};

    if (nameController.text.trim().isNotEmpty) {
      fields['name'] = nameController.text.trim();
    }

    if (emailController.text.trim().isNotEmpty) {
      fields['email'] = emailController.text.trim();
    }

    if (fields.isEmpty && selectedImage.value == null) {
      return false;
    }

    final response = await networkCaller.multipartRequest(
      Urls.profileUpdate,
      fields,
      file: selectedImage.value,
      fileField: "file",
      token: token,
    );

    if (response != null && response['success'] == true) {
      return true;
    }

    return false;
  } catch (_) {
    return false;
  } finally {
    isLoading.value = false;
  }
}

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
