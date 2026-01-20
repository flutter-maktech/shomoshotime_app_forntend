import 'dart:convert';

import 'package:http/http.dart' as http;

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
      onAuthorizer:
          (String channelName, String socketId, dynamic options) async {
            print("🔐 Authorizing for channel: $channelName");

            final authUrl =
                'https://shomoshotime.mtscorporate.com/api/v1/broadcasting/auth';

            try {
              var response = await http.post(
                Uri.parse(authUrl),

                headers: {
                  'Content-Type': 'application/x-www-form-urlencoded',

                  'Accept': 'application/json',

                  'Authorization': 'Bearer $token',
                },

                body: 'socket_id=$socketId&channel_name=$channelName',
              );

              if (response.statusCode == 200) {
                return jsonDecode(response.body);
              } else {
                print(
                  "❌ Auth Error: ${response.statusCode} - ${response.body}",
                );

                return null;
              }
            } catch (e) {
              print("🚨 Auth Exception: $e");

              return null;
            }
          },

      onEvent: (event) {
        print('📡 Channel: ${event.channelName}, Event: ${event.eventName}');

        if (event.data != null) {
          try {
            final data = json.decode(event.data!);
            if (event.eventName.contains('notification')) {
              print('🎯 NOTIFICATION DETECTED!');

              onNotificationReceived(data);
            }
          } catch (e) {
            print("📦 Error decoding event data: $e");
          }
        }
      },

      onSubscriptionSucceeded: (channelName, data) {
        print('✅ Subscribed to channel: $channelName');
      },

      onSubscriptionError: (channelName, message) {
        print('❌ Failed to subscribe to $channelName: $message');
      },
    );

    await _pusher.connect();
    await _pusher.subscribe(channelName: 'global.notifications');
    final userChannel = 'private-user.$userId';

    print('🚀 Attempting to subscribe to private channel: $userChannel');

    await _pusher.subscribe(channelName: userChannel);
  }

  Future<void> disconnect() async {
    await _pusher.disconnect();
  }
}
