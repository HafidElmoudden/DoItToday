import 'package:shared_preferences/shared_preferences.dart';
class SaveUser {
  static void saveUserName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
  } 

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('username');
    return name;
  }
}