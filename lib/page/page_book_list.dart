import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterreader/base/api.dart';
import 'package:flutterreader/data/response/booklist.dart';
import 'package:flutterreader/entity/category.dart';
import 'package:flutterreader/net/http_utils.dart';
import 'package:flutterreader/res/gaps.dart';

import '../category_page.dart';

double circular = 6;

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> _list = [];
  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('书籍列表'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            Book item = _list[index];
            return Material(
//                        color: Colors.red,
              child: InkWell(
                onTap: () {},
                child: NewsItemLeft(item),
              ),
            );
          }),
    );
  }

  init() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get("https://novel.juhe.im/books");
    BookList bookList = BookList.fromMap(response.data);
    setState(() {
      _list = bookList.books;
    });
//    print(category);
  }
}

class NewsItemLeft extends StatelessWidget {
  final Book book;

  NewsItemLeft(this.book);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor.withAlpha(10),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(
        bottom: 10,
      ),
      height: 120,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _imageWidget(context, book),
          Gaps.hGap10,
          _leftOrRightWidget(context, book),
        ],
      ),
    );
  }
}

_leftOrRightWidget(BuildContext context, Book book) {
  Widget widget;

  widget = Expanded(
    child: Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
          children: [
            Expanded(
              child: Container(
//                      color: Colors.green,
                  child: Center(
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    book.shortIntro,
                    style: Theme.of(context).textTheme.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
            ),
            Expanded(
              child: Container(
//                      color: Colors.green,
                  child: Center(
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    book.title,
                    style: Theme.of(context).textTheme.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
            ),
          ]),
    ),
  );

  return widget;
}

_imageWidget(BuildContext context, Book book) {
  Widget widget;
  widget = Container(
    width: 110,
    height: 85,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(circular),
      child: Image.network(book.cover),
    ),
  );

  return widget;
}
