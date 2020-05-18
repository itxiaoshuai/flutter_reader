import 'package:flutter/material.dart';

import 'base/api.dart';
import 'data/categories_req.dart';
import 'net/http_utils.dart';

class CategoryPage extends StatefulWidget {
  final String major;
  final String gender;

  CategoryPage(
    this.gender,
    this.major,
  );
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('xx'),
    );
  }

  Future<void> init() async {
    CategoriesReq categoriesReq = CategoriesReq();
    categoriesReq.gender = this.widget.gender;
    categoriesReq.major = this.widget.major;
    categoriesReq.type = "hot";
    categoriesReq.start = 0;
    categoriesReq.limit = 40;
    var jsonString = await httpUtil.get(Api.categories,
        queryParameters: categoriesReq.toJson());

    print(jsonString);
  }
}
