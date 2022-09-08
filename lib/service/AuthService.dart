import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:teste/common/HttpBase.dart';
import 'package:teste/common/LocalStorage.dart';
import 'package:teste/model/login/LoginForm.dart';
import 'package:teste/model/login/User.dart';

class AuthService {
  static Future<Object> login(LoginForm form) async {
    var results = await HttpBase.post("/v1/login", form.toJson());

    Map<String, dynamic> decodedToken = JwtDecoder.decode(results['token']);

    var user = User.fromJson(decodedToken);
    user.token = results['token'];

    LocalStorage.saveUserData(user);

    return user;
  }
}
