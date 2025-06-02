import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/user.dart';

class AuthRepository {
  static const String _userKey = 'user';
  static const String _loggedInKey = 'logged_in';

  Future<bool> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    // Save user as JSON string
    await prefs.setString(_userKey, user.toJson().toString());
    await prefs.setBool(_loggedInKey, true);
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);
    if (userString == null) return false;
    final userMap = _stringToMap(userString);
    if (userMap['email'] == email && userMap['password'] == password) {
      await prefs.setBool(_loggedInKey, true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  Map<String, dynamic> _stringToMap(String str) {
    // Remove curly braces and split by comma
    final map = <String, dynamic>{};
    str.replaceAll('{', '').replaceAll('}', '').split(',').forEach((pair) {
      final kv = pair.split(':');
      if (kv.length == 2) {
        map[kv[0].trim()] = kv[1].trim();
      }
    });
    return map;
  }
}