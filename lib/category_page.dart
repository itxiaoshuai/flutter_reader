import 'dart:convert';

import 'package:flutter/material.dart';

import 'base/api.dart';
import 'data/categories_req.dart';
import 'data/response/categories_resp.dart';
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
  List<Book> _list = [];
  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(
                child: Text(_list[index].title),
              ),
            );
          }),
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
    CategoriesResp categoriesResp =
        CategoriesResp.fromMap(json.decode(jsonString));

    setState(() {
      _list = categoriesResp.books;
    });
    print(categoriesResp.total);
  }
}
