import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutterreader/manager/resource_mananger.dart';
import 'package:flutterreader/read/request.dart';
import 'package:flutterreader/res/img.dart';
import 'package:flutterreader/utils/screen.dart';

import 'article.dart';
import 'chapter.dart';

enum PageJumpType { stay, firstPage, lastPage }

class ReaderScene extends StatefulWidget {
  final int articleId;

  ReaderScene({this.articleId});

  @override
  ReaderSceneState createState() => ReaderSceneState();
}

class ReaderSceneState extends State<ReaderScene> with RouteAware {
  Article preArticle;
  Article currentArticle;
  Article nextArticle;
  PageController pageController = PageController(keepPage: false);
  buildPageView() {
    if (currentArticle == null) {
      return Container();
    }

    int itemCount = (preArticle != null ? preArticle.pageCount : 0) +
        currentArticle.pageCount +
        (nextArticle != null ? nextArticle.pageCount : 0);
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: pageController,
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: onPageChanged,
    );
  }

  onPageChanged(int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    if (page < currentArticle.pageCount && page >= 0) {
      setState(() {
//        pageIndex = page;
      });
    }
  }

  Widget buildPage(BuildContext context, int index) {
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    var article;
    if (page >= this.currentArticle.pageCount) {
      // 到达下一章了
      article = nextArticle;
      page = 0;
    } else if (page < 0) {
      // 到达上一章了
      article = preArticle;
      page = preArticle.pageCount - 1;
    } else {
      article = this.currentArticle;
    }

    return GestureDetector(
      onTapUp: (TapUpDetails details) {},
    );
  }

  @override
  void initState() {
    super.initState();
    pageController.addListener(onScroll);
    setup();
  }

  List<Chapter> chapters = [];
  void setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    List<dynamic> chaptersResponse = await Request.get(action: 'catalog');
    chaptersResponse.forEach((data) {
      chapters.add(Chapter.fromJson(data));
    });

//    await resetContent(this.widget.articleId, PageJumpType.stay);
  }

  onScroll() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset(
                    ImageHelper.wrapAssets(ConstImgResource.readBg),
                    fit: BoxFit.cover)),
            buildPageView(),
          ],
        ),
      ),
    );
  }
}
