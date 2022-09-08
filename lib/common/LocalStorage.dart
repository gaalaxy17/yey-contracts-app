import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/model/login/User.dart';

class LocalStorage {
  static Future init() async {}

  static Future saveUserData(User user) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    await _sharedPreferences.setString("id", user.id!);
    await _sharedPreferences.setString("username", user.username!);
    await _sharedPreferences.setInt("roleId", user.roleId!);
    await _sharedPreferences.setString("token", user.token!);
  }

  static Future getUserData() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    User? user;

    if (_sharedPreferences.getString("token") != null) {
      user = new User(
          id: _sharedPreferences.getString("id"),
          username: _sharedPreferences.getString("username"),
          roleId: _sharedPreferences.getInt("roleId"),
          token: _sharedPreferences.getString("token"));
    }

    return user;
  }
}
