import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _imageKey = 'user_image';
  static const String _planIdKey = 'current_plan_id';
  static const String _audioProgressPrefix = 'audio_progress_';
  static const String _flashcardProgressPrefix = 'flashcard_progress_';
  static const String _questionProgressPrefix = 'question_progress_';

  // PROFILE IMAGE
  static Future<void> saveProfileImage(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageKey, url);
  }

  static Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_imageKey);
  }

  static Future<void> clearProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_imageKey);
  }

  // TOKEN
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // USER ID
  static Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  static Future<void> saveUserIdAsString(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  static Future<String?> getUserIdAsString() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<void> clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }

  // CURRENT PLAN
  static Future<void> saveCurrentPlan(String plan) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_planIdKey, plan);
  }

  static Future<String?> getCurrentPlan() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_planIdKey);
  }

  static Future<void> clearCurrentPlan() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_planIdKey);
  }

  // AUDIO PROGRESS
  static Future<void> saveAudioProgress(String url, int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_audioProgressPrefix$url', seconds);
  }

  static Future<int> getAudioProgress(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_audioProgressPrefix$url') ?? 0;
  }

  // FLASHCARD PROGRESS
  static Future<void> saveFlashcardProgress(int contentId, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_flashcardProgressPrefix$contentId', index);
  }

  static Future<int> getFlashcardProgress(int contentId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_flashcardProgressPrefix$contentId') ?? 0;
  }

  // QUESTION PROGRESS (Practice & Mock Exams)
  static Future<void> saveQuestionProgress(int questionSetId, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_questionProgressPrefix$questionSetId', index);
  }

  static Future<int> getQuestionProgress(int questionSetId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_questionProgressPrefix$questionSetId') ?? 0;
  }

  // CLEAR ALL - For logout
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_imageKey);
  }
}
