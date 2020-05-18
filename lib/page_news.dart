import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterreader/entity/category.dart';
import 'package:flutterreader/manager/request_manager.dart';
import 'package:flutterreader/provider/provider_widget.dart';
import 'package:flutterreader/provider/view_state_widget.dart';
import 'base/api.dart';
import 'category_page.dart';
import 'generated/i18n.dart';
import 'manager/router_manger.dart';
import 'model/category_model.dart';
import 'model/news_model.dart';
import 'net/http_utils.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Category category;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
//    RequestManager.fetchNews();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language.of(context).tabNews',
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFEEEEEE),
        padding: EdgeInsets.only(bottom: 54.0),
        child: category == null
            ? Container()
            : GridViewCustomDemo(
                category: category,
              ),
      ),
    );
  }

  Future<void> init() async {
    var jsonString = await httpUtil.get(Api.category);
    category = Category.fromMap(json.decode(jsonString));
    print(category);
  }
}

class GridViewCustomDemo extends StatelessWidget {
  Category category;

  GridViewCustomDemo({
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.custom(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        childrenDelegate: SliverChildListDelegate(
          List.generate(category.male.length, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage('male', '玄幻')),
                );
              },
              child: Image.network(
                Api.IMG_BASE_URL + category.male[index].bookCover[0],
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.colorBurn,
                color: Colors.white10,
              ),
            );
          }),
        ),
      ),
    );
  }
}
