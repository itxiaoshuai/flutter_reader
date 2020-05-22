import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterreader/base/base_constants.dart';
import 'package:flutterreader/data/response/chapter_content.dart';
import 'package:flutterreader/manager/resource_mananger.dart';
import 'package:flutterreader/read/reader_page_agent.dart';
import 'package:flutterreader/res/gaps.dart';
import 'package:flutter/src/widgets/image.dart' deferred as img;
import 'package:flutterreader/res/img.dart';
import 'package:flutterreader/utils/screen.dart';

class ReaderPage extends StatefulWidget {
  final String url;

  ReaderPage({this.url});

  @override
  ReaderPageState createState() => ReaderPageState();
}

class ReaderPageState extends State<ReaderPage> {
  List<String> _list = [];
  String _content = '';
  PageController pageController = PageController(keepPage: false);

  @override
  void initState() {
    super.initState();
    init(widget.url);
  }

  init(String url) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get('http://api.pingcc.cn/?xsurl2=' + url);

    BookChapterContent chapterContent =
        BookChapterContent.fromMap(jsonDecode(response.data));
    setState(() {
      _list = chapterContent.content;
      _list.forEach((item) {
//        print(item);
        _content = _content + '　　' + item + '\n';
      });
      print(_content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemChrome.setEnabledSystemUIOverlays([]),
        child: GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: img.Image.asset(
                        ImageHelper.wrapAssets(ConstImgResource.readBg),
                        fit: BoxFit.cover)),
                buildPageView(),
              ],
            )),
      ),
    );
  }

  Widget buildPage(BuildContext context, int index) {
//    final width = Screen.width;
//    final height = Screen.height;
//    print('width is $width; height is $height');
//    ReaderPageAgent.getPageOffsets(_list.toString(), height, width, 18);
    return GestureDetector(
        child: Container(
      child: Text(_content),
    ));
  }

  buildPageView() {
    int itemCount = 10;

    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: pageController,
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: (index) {
        print(index);
      },
    );
  }
}
