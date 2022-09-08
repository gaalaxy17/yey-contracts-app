import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:teste/common/LocalStorage.dart';
import 'package:teste/enviroment/Environment.dart';
import 'package:dio/dio.dart';
import 'package:teste/model/login/User.dart';

class HttpBase {
  static Dio getDio() {
    Dio dio = new Dio();

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      User? user = await LocalStorage.getUserData();

      if (user != null && user.token != null) {
        options.headers.addAll({'authorization': 'Bearer ${user.token}'});
      }

      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError e, handler) {
      if (e.response!.statusCode == 401) {
        print("Unauthorized, should redirect to login...");
      }
      return handler.next(e);
    }));

    return dio;
  }

  static Future<Map<String, dynamic>> get(
      String path, Map<String, dynamic>? params) async {
    try {
      EasyLoading.show(status: 'Carregando...');
      var url = '${Enviroment.API_ENDPOINT}$path';

      if (params != null) {
        List<String> keysToRemove = [];
        params.forEach((key, value) => {
              if (value == null || value == '') {keysToRemove.add(key)}
            });

        if (keysToRemove.length > 0) {
          keysToRemove.forEach((element) => {params.remove(element)});
        }
      }

      var results = await getDio().get(
        url,
        queryParameters: params,
      );
      EasyLoading.showSuccess('Sucesso!');
      return results.data;
    } on DioError catch (e) {
      print(e);
      EasyLoading.showError(e.response!.data['message']);

      var errorMap = new Map<String, dynamic>();
      errorMap['error'] = e.error;

      return errorMap;
    }
  }

  static Future<Map<String, dynamic>> patch(
      String path, Map<String, dynamic>? params) async {
    try {
      EasyLoading.show(status: 'Carregando...');
      var url = '${Enviroment.API_ENDPOINT}$path';

      if (params != null) {
        List<String> keysToRemove = [];
        params.forEach((key, value) => {
              if (value == null || value == '') {keysToRemove.add(key)}
            });

        if (keysToRemove.length > 0) {
          keysToRemove.forEach((element) => {params.remove(element)});
        }
      }

      var results = await getDio().patch(
        url,
        queryParameters: params,
      );
      EasyLoading.showSuccess('Sucesso!');
      return results.data;
    } on DioError catch (e) {
      print(e);
      EasyLoading.showError(e.response!.data['message']);

      var errorMap = new Map<String, dynamic>();
      errorMap['error'] = e.error;

      return errorMap;
    }
  }

  static Future<Map<String, dynamic>> post(String path, Object obj) async {
    try {
      EasyLoading.show(status: 'Carregando...');
      var url = '${Enviroment.API_ENDPOINT}$path';
      var results = await getDio().post(
        url,
        data: obj,
      );
      EasyLoading.showSuccess('Sucesso!');
      return results.data;
    } on DioError catch (e) {
      EasyLoading.showError(e.response!.data['message']);
      var errorMap = new Map<String, dynamic>();
      errorMap['error'] = e.error;
      return errorMap;
    }
  }
}
