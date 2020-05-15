import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterreader/base/base_constants.dart';

import 'http.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = BaseConstants.API_BASE_URL;
    interceptors..add(ApiInterceptor());
//       cookie持久化 异步
//      ..add(CookieManager(
//          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}' +
        ' data: ${options.data}');

    return options;
  }

  @override
  onResponse(Response response) {
    debugPrint(response.toString());
//    final jsonResponse = json.decode(response.data);
//    debugPrint(jsonResponse);
  }
}
