import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shomoshotime/app/all_utils/log.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

class NetworkCaller {
  // GET Request
  Future<dynamic> getRequest(String url, {String? token}) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        'Authorization': "Bearer$token",
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      AppLogger.log("GET Request to: $url");
      AppLogger.log("Headers: $headers");

      final response = await http.get(Uri.parse(url), headers: headers);

      AppLogger.log("GET Status: ${response.statusCode}");
      AppLogger.log("GET Response: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        _handleSessionExpired();
        throw Exception("Unauthorized: Invalid Token");
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      AppLogger.log("GET Request Error: $e");
      rethrow;
    }
  }

  // POST Request
  Future<dynamic> postRequest(
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      AppLogger.log("POST Request to: $url");
      AppLogger.log("Headers: $headers");
      AppLogger.log("Body: $body");

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      AppLogger.log("POST Status: ${response.statusCode}");
      AppLogger.log("POST Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        _handleSessionExpired();
        throw Exception("Unauthorized: Invalid Token");
      } else {
        throw Exception(
          "Failed to post data:$url ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      AppLogger.log("POST Request Error: $e");
      rethrow;
    }
  }

  // PUT Request
  Future<dynamic> patchRequest(
    String url,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      AppLogger.log("PUT Request to: $url");
      AppLogger.log("Headers: $headers");
      AppLogger.log("Body: $body");

      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      AppLogger.log("PUT Status: ${response.statusCode}");
      AppLogger.log("PUT Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        _handleSessionExpired();
        throw Exception("Unauthorized: Invalid Token");
      } else {
        throw Exception(
          "Failed to update data: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      AppLogger.log("PUT Request Error: $e");
      rethrow;
    }
  }

  // DELETE Request
  Future<void> deleteRequest(String url, {String? token}) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      AppLogger.log("DELETE Request to: $url");
      AppLogger.log("Headers: $headers");

      final response = await http.delete(Uri.parse(url), headers: headers);

      AppLogger.log("DELETE Status: ${response.statusCode}");
      AppLogger.log("DELETE Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      } else if (response.statusCode == 401) {
        _handleSessionExpired();
        throw Exception("Unauthorized: Invalid Token");
      } else {
        throw Exception(
          "Failed to delete data: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      AppLogger.log("DELETE Request Error: $e");
      rethrow;
    }
  }

  Future<String> googleSignInRequest(String url, String accessToken) async {
    try {
      final fullUrl = '$url?access_token=$accessToken';

      final response = await http.post(
        Uri.parse(fullUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({}),
      );

      AppLogger.log("url ====== $fullUrl");
      AppLogger.log("Status Code: ${response.statusCode}");
      AppLogger.log("Response: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw "Server Error: ${response.body}";
      }

      final data = jsonDecode(response.body);
      return data["access_token"];
    } catch (e) {
      throw "Google Authentication Request Failed: $e";
    }
  }

  void _handleSessionExpired() {
    Get.offAllNamed(Routes.SESSION_EXPIRED);
  }
}
