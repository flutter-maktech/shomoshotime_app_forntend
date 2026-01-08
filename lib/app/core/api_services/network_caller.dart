import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkCaller {
  // GET Request
  Future<dynamic> getRequest(String url, {String? token}) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
        'Authorization':"Bearer$token"
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      print("GET Request to: $url");
      print("Headers: $headers");

      final response = await http.get(Uri.parse(url), headers: headers);

      print("GET Status: ${response.statusCode}");
      print("GET Response: ${response.body}");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Invalid Token");
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("GET Request Error: $e");
      rethrow;
    }
  }

  // POST Request
  Future<dynamic> postRequest(String url, Map<String, dynamic> body,
      {String? token}) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      print("POST Request to: $url");
      print("Headers: $headers");
      print("Body: $body");

      final response =
      await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));

      print("POST Status: ${response.statusCode}");
      print("POST Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            "Failed to post data: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("POST Request Error: $e");
      rethrow;
    }
  }

  // PUT Request
  Future<dynamic> patchRequest(String url, Map<String, dynamic> body,
      {String? token}) async {
    try {
      final headers = {
        "accept": "application/json",
        "Content-Type": "application/json",
      };

      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = "Bearer $token";
      }

      print("PUT Request to: $url");
      print("Headers: $headers");
      print("Body: $body");

      final response =
      await http.patch(Uri.parse(url), headers: headers, body: jsonEncode(body));

      print("PUT Status: ${response.statusCode}");
      print("PUT Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            "Failed to update data: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("PUT Request Error: $e");
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

      print("DELETE Request to: $url");
      print("Headers: $headers");

      final response = await http.delete(Uri.parse(url), headers: headers);

      print("DELETE Status: ${response.statusCode}");
      print("DELETE Response: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
            "Failed to delete data: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("DELETE Request Error: $e");
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

      print("url ====== $fullUrl");
      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw "Server Error: ${response.body}";
      }

      final data = jsonDecode(response.body);
      return data["access_token"];
    } catch (e) {
      throw "Google Authentication Request Failed: $e";
    }
  }



}
