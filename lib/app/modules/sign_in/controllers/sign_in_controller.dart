import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../all_utils/app_preference.dart';
import '../../../all_utils/log.dart';
import '../../../core/api_services/firebase_services.dart';
import '../../../core/api_services/network_caller.dart';
import '../../../data/app_colors.dart';
import '../../../all_utils/show_app_snack_bar.dart';
import '../../../core/auth_model/sign_in_model.dart';
import '../../../core/urls/urls.dart';
import '../../../routes/app_pages.dart';
import '../../custom_bottom_navigation_bar/controllers/custom_bottom_navigation_bar_controller.dart';

class SignInController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode focusNode;
  // Password visibility
  RxBool isVisible = true.obs;

  void visibleOnTap() {
    isVisible.toggle();
  }

  // Form validation
  final formKey = GlobalKey<FormState>();

  // API
  final NetworkCaller networkCaller = NetworkCaller();

  RxBool isLoading = false.obs;
  RxString message = ''.obs;

  // Sign in button action
  Future<void> signIn() async {
    try {
      if (!formKey.currentState!.validate()) return;

      final model = SignInModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        fcmToken: "dummy_fcm_token",
      );

      final success = await loginUser(model);

      if (success) {
        showAppSnackBar(
          context: Get.context!,
          message: message.value,
          backgroundColor: AppColors.greenColor,
        );
        Get.offAllNamed(Routes.appGate);
      } else {
        showAppSnackBar(
          context: Get.context!,
          message: message.value,
          backgroundColor: AppColors.readColor,
        );
      }
    } catch (e) {
      ////
    }
  }

  // Login API call
  Future<bool> loginUser(SignInModel model) async {
    try {
      isLoading.value = true;

      final response = await networkCaller.postRequest(
        Urls.logInUrl,
        model.toJson(),
      );

      Map<String, dynamic> data;

      if (response is String) {
        data = jsonDecode(response);
      } else if (response is Map) {
        data = Map<String, dynamic>.from(response);
      } else {
        message.value = 'Invalid server response';
        return false;
      }

      if (data['success'] == true) {
        final token = data['data']['token'];
        final userId = data['data']['user_id'];
        final image = data['data']['image'];
        String? currentPlan;
        if (data['data']['plans']['current'] != null) {
          currentPlan = data['data']['plans']['current']['name'];
          AppLogger.log('✅ $currentPlan');
        }

        // Save token, user ID, and image
        AppPreference.saveToken(token.toString());
        AppPreference.saveUserId(userId);
        if (currentPlan != null) {
          AppPreference.saveCurrentPlan(currentPlan);
        }
        if (image != null) {
          AppPreference.saveProfileImage(image);
          if (Get.isRegistered<CustomBottomNavigationBarController>()) {
            Get.find<CustomBottomNavigationBarController>().updateProfileImage(
              image,
            );
          }
        }

        message.value = data['message'] ?? 'Login successful';
        return true;
      } else {
        // 🔥 Extract validation message properly
        if (data['data'] != null && data['data'] is Map) {
          final errorMap = data['data'] as Map<String, dynamic>;

          if (errorMap.isNotEmpty) {
            final firstError = errorMap.values.first;

            if (firstError is List && firstError.isNotEmpty) {
              message.value = firstError.first;
            } else {
              message.value = 'Login failed';
            }
          } else {
            message.value = 'Login failed';
          }
        } else {
          message.value = 'Login failed';
        }

        return false;
      }
    } catch (e) {
      message.value = 'Login failed: $e';
      AppLogger.log('❌ $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      // Import Firebase service
      final firebaseService = FirebaseAuthService();

      // Sign in with Google via Firebase
      final userData = await firebaseService.signInWithGoogle();

      if (userData == null) {
        // User cancelled or sign-in failed
        message.value = 'Google sign-in cancelled';
        showAppSnackBar(
          context: Get.context!,
          message: message.value,
          backgroundColor: AppColors.readColor,
        );
        return;
      }

      // Call backend API with Google user data
      final success = await _googleLoginApi(userData);

      if (success) {
        showAppSnackBar(
          context: Get.context!,
          message: message.value,
          backgroundColor: AppColors.greenColor,
        );
        Get.offAllNamed(Routes.appGate);
      } else {
        showAppSnackBar(
          context: Get.context!,
          message: message.value,
          backgroundColor: AppColors.readColor,
        );
      }
    } catch (e) {
      message.value = 'Google sign-in failed: ${e.toString()}';
      showAppSnackBar(
        context: Get.context!,
        message: message.value,
        backgroundColor: AppColors.readColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Google Login API call
  Future<bool> _googleLoginApi(Map<String, String> userData) async {
    try {
      final response = await networkCaller.postRequest(
        Urls.googleLogin,
        userData,
      );

      Map<String, dynamic> data;

      if (response is String) {
        data = jsonDecode(response);
      } else if (response is Map) {
        data = Map<String, dynamic>.from(response);
      } else {
        message.value = 'Invalid server response';
        return false;
      }

      if (data['success'] == true) {
        final token = data['data']['token'];
        final userId = data['data']['user_id'];
        final image = data['data']['image'];
        String? currentPlan;
        if (data['data']['plans']['current'] != null) {
          currentPlan = data['data']['plans']['current']['name'];
          AppLogger.log('✅ $currentPlan');
        }

        // Save token, user ID, and image
        AppPreference.saveToken(token);
        AppPreference.saveUserId(userId);
        if (currentPlan != null) {
          AppPreference.saveCurrentPlan(currentPlan);
        }
        if (image != null) {
          AppPreference.saveProfileImage(image);
          if (Get.isRegistered<CustomBottomNavigationBarController>()) {
            Get.find<CustomBottomNavigationBarController>().updateProfileImage(
              image,
            );
          }
        }

        message.value = data['message'] ?? 'Login successful';
        return true;
      } else {
        message.value = data['message'] ?? 'Login failed';
        return false;
      }
    } catch (e) {
      message.value = 'Login failed: ${e.toString()}';
      return false;
    }
  }

  void onAppInitial() {
    try {
      emailController = TextEditingController();
      passwordController = TextEditingController();
      focusNode = FocusNode();
    } catch (e) {
      ////
    }
  }

  void onAppClose() {
    try {
      emailController.dispose();
      passwordController.dispose();
      focusNode.dispose();
    } catch (e) {
      ////
    }
  }

  @override
  void onInit() {
    onAppInitial();
    super.onInit();
  }

  @override
  void onClose() {
    onAppClose();
    super.onClose();
  }
}
