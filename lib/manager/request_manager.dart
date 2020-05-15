/*
请求管理类
 */
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterreader/base/api.dart';
import 'package:flutterreader/entity/category.dart';
import 'package:flutterreader/entity/news.dart';
import 'package:flutterreader/net/http_request.dart';
import 'package:flutterreader/net/http_utils.dart';

class RequestManager {
  // 资讯
  static Future<List<News>> fetchNews() async {
    var response = await http.get('index.php?c=App&a=getNews&p=1');
    List<News> newsList =
        response.data['list'].map<News>((item) => News.fromMap(item)).toList();
    debugPrint('---api-request--->url--> ${newsList.length}');
    return newsList;
  }

  // 分类
  static Future<Category> fetchCategoryList() async {
    var jsonString = await httpUtil.get(Api.category);
    Category category = Category.fromMap(json.decode(jsonString));
    return category;
  }
}
