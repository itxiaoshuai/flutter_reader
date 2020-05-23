import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterreader/data/response/book_detail.dart';
import 'package:flutterreader/read/page_reader.dart';
import 'package:flutterreader/res/gaps.dart';

class BookDetailPage extends StatefulWidget {
  final String url;

  BookDetailPage({this.url});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  List<Chapter> _list = [];

  @override
  void initState() {
    super.initState();
    init(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('目录'),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReaderPage(
                                  chapters: _list,
                                  chapterIndex: index,
                                )),
                      );
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gaps.line,
                          Text(
                            _list[index].url,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 25, top: 20, bottom: 20),
                              child: Text(
                                _list[index].num,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  init(String url) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get("http://api.pingcc.cn/?xsurl1=" + url);
    BookDetail bookDetail = BookDetail.fromMap(json.decode(response.data));
    setState(() {
      _list = bookDetail.list;
    });
  }
}
