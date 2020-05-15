import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterreader/entity/category.dart';
import 'package:flutterreader/net/http_request.dart';
import 'package:flutterreader/provider/view_state_refresh_model.dart';

class CategoryModel extends ViewStateRefreshModel {
  @override
  Future loadData() async {
    var response = await http.get('/cats/lv2/statistics');
    var parsedUserList = json.decode(response.toString());
    debugPrint('xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//    Category category = Category.fromJson(parsedUserList);
    return response;
  }
}
