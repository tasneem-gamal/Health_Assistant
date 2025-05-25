import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<void> saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
  }

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  static Future<void> clearUid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
  }
}
