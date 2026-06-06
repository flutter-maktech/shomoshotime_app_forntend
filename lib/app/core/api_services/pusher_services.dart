import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../all_utils/app_preference.dart';

class PusherService {
  final PusherChannelsFlutter _pusher = PusherChannelsFlutter.getInstance();

  Future<void> initPusher({

    required Function(Map<String, dynamic>) onNotificationReceived,
  }) async {
    final token = await AppPreference.getToken();
    final userId = await AppPreference.getUserId();

    await _pusher.init(
      apiKey: '21418a6fbf35977fa87d',

      cluster: 'ap2',
      onAuthorizer:
          (String channelName, String socketId, dynamic options) async {
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

                return null;
              }
            } catch (e) {
              return null;
            }
          },

      onEvent: (event) {
        if (event.data != null) {
          try {
            final data = json.decode(event.data!);
            if (event.eventName.contains('notification')) {
              onNotificationReceived(data);
            }
          } catch (e) {
            throw Exception(e);
          }
        }
      },

      onSubscriptionSucceeded: (channelName, data) {},

      onSubscriptionError: (channelName, message) {},
    );

    await _pusher.connect();
    await _pusher.subscribe(channelName: 'global.notifications');
    final userChannel = 'private-user.$userId';

    await _pusher.subscribe(channelName: userChannel);
  }

  Future<void> disconnect() async {
    await _pusher.disconnect();
  }
}
