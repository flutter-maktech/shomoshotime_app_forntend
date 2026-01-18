import 'dart:convert';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:shomoshotime/app/all_utils/app_preference.dart';

class PusherService {
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  Future<void> initPusher({
  required String userId,
  required Function(Map<String, dynamic>) onNotificationReceived,
}) async {
  final token = await AppPreference.getToken();
  await _pusher.init(
    apiKey: '21418a6fbf35977fa87d',
    cluster: 'ap2',
    authEndpoint: 'https://shomoshotime.mtscorporate.com/broadcasting/auth',
    authParams: {
      'headers': {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    },
    onEvent: (event) {
      print('📡 Channel: ${event.channelName}, Event: ${event.eventName}');
      
      // Handle user.notification events specifically
      if (event.eventName == 'user.notification' && event.data != null) {
        print('🎯 USER NOTIFICATION EVENT DETECTED!');
        print('📦 Raw data: ${event.data}');
        final data = json.decode(event.data!);
        onNotificationReceived(data);
      }
      
      // Handle global notifications
      if (event.eventName == 'global.notification' && event.data != null) {
        print('🌍 GLOBAL NOTIFICATION EVENT DETECTED!');
        final data = json.decode(event.data!);
        onNotificationReceived(data);
      }
    },
    onSubscriptionSucceeded: (channelName, data) {
      print('✅ Subscribed to channel: $channelName');
    },
    onSubscriptionError: (channelName, message,) {
      print('❌ Failed to subscribe to $channelName: $message');
    },
  );

  await _pusher.connect();

  // Subscribe to channels
  await _pusher.subscribe(channelName: 'global.notifications');
  
  // IMPORTANT: Match EXACTLY what's in Pusher debug console
  // From your screenshot: Channel is 'private-user1' (no dot after 'user')
  final userChannel = 'private-user$userId'; // This creates 'private-user1'
  print('Attempting to subscribe to user channel: $userChannel');
  await _pusher.subscribe(channelName: userChannel);
  
  // Also try alternative formats if above doesn't work
  // await _pusher.subscribe(channelName: 'private-user.$userId'); // With dot
  // await _pusher.subscribe(channelName: 'user$userId'); // Without 'private-' prefix
}

  Future<void> disconnect() async {
    await _pusher.disconnect();
  }
}
