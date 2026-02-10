import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/log.dart';
import '../../../core/api_services/pusher_services.dart';
import '../../../core/user_panel_model/notification_model.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';
import 'package:shomoshotime/app/core/api_services/network_caller.dart';
import 'package:shomoshotime/app/core/urls/urls.dart';

class NotificationController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final RxList<UserNotification> notifications = <UserNotification>[].obs;
  bool get hasUnread => notifications.any((n) => !n.isRead);
  int get unreadCount => notifications.where((n) => !n.isRead).length;

  final NetworkCaller networkCaller = NetworkCaller();
  final PusherService _pusherService = PusherService(); // ✅ SINGLE instance

  @override
  void onInit() {
    super.onInit();

    // ✅ 1. Load existing notifications FIRST
    fetchNotifications();

    // ✅ 2. Listen for real-time updates
    _pusherService.initPusher(
      onNotificationReceived: (data) {
        AppLogger.log('🔔 PUSHER EVENT RECEIVED: $data');
        // Refresh notifications when admin sends one
        fetchNotifications();
      },
    );
  }

  @override
  void onClose() {
    _pusherService.disconnect(); // ✅ correct instance
    super.onClose();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final token = await AppPreference.getToken();

      final response = await networkCaller.postRequest(
        Urls.notification,
        {},
        token: token,
      );

      if (response['success'] == true) {
        notifications.value = (response['data'] as List)
            .map((e) => UserNotification.fromJson(e))
            .toList();
      } else {
        errorMessage.value = response['message'] ?? 'Something went wrong';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsRead(int id) async {
    try {
      final token = await AppPreference.getToken();

      await networkCaller.postRequest(Urls.notificationMarkAsRead, {
        "id": id,
        "is_read": "1",
      }, token: token);

      final index = notifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        notifications[index] = notifications[index].copyWith(isRead: true);
      }
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }
}
