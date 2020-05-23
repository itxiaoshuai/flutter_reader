import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterreader/base/base_constants.dart';
import 'package:flutterreader/data/response/article.dart';
import 'package:flutterreader/data/response/book_detail.dart';
import 'package:flutterreader/manager/resource_mananger.dart';
import 'package:flutterreader/read/reader_config.dart';
import 'package:flutterreader/read/reader_page_agent.dart';
import 'package:flutterreader/read/reader_utils.dart';
import 'package:flutterreader/read/reader_view.dart';
import 'package:flutterreader/res/gaps.dart';
import 'package:flutter/src/widgets/image.dart' deferred as img;
import 'package:flutterreader/res/img.dart';
import 'package:flutterreader/utils/screen.dart';
import 'package:flutterreader/utils/utility.dart';

enum PageJumpType { stay, firstPage, lastPage }

class ReaderPage extends StatefulWidget {
  final int chapterIndex;
  final List<Chapter> chapters;

  ReaderPage({
    this.chapters,
    this.chapterIndex,
  });

  @override
  ReaderPageState createState() => ReaderPageState();
}

class ReaderPageState extends State<ReaderPage> {
  PageController pageController = PageController(keepPage: false);
  double topSafeHeight = 0;
  Article preArticle; //前一章节
  Article currentArticle; //当前章节
  Article nextArticle; //下一章节
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();

    ///PageView设置滑动监听
    pageController.addListener(() {
      //PageView滑动的距离
      double offset = pageController.offset;
      print("pageView 滑动的距离 $offset");
    });
    setup();
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
      onTapUp: (TapUpDetails details) {
//        onTap(details.globalPosition);
      },
      child: ReaderView(
          article: article, page: page, topSafeHeight: topSafeHeight),
    );
  }

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
      onPageChanged: (index) {
        print(index);
      },
    );
  }

  Future<Article> fetchArticle(String articleId) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get('http://api.pingcc.cn/?xsurl2=' + articleId);
    Article article = Article.fromMap(jsonDecode(response.data));
    var contentHeight = Screen.height -
        topSafeHeight -
        ReaderUtils.topOffset -
        Screen.bottomSafeHeight -
        ReaderUtils.bottomOffset -
        20;
    var contentWidth = Screen.width - 15 - 10;
    String stringContent = '';
    article.content.forEach((item) {
      stringContent = stringContent + '　　' + item + '\n';
    });
    print('stringContent$stringContent');
    article.chapterName = this.widget.chapters[this.widget.chapterIndex].num;
    article.stringContent = stringContent;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(article.stringContent,
        contentHeight, contentWidth, ReaderConfig.instance.fontSize);
    print(article.pageOffsets);
    return article;
  }

  Future<void> setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    topSafeHeight = Screen.topSafeHeight;
    await resetContent(
        this.widget.chapters[this.widget.chapterIndex].url, PageJumpType.stay);
  }

  resetContent(String articleId, PageJumpType jumpType) async {
    currentArticle = await fetchArticle(articleId);
    //获取前一章节
    if (this.widget.chapterIndex > 0) {
      articleId = this.widget.chapters[this.widget.chapterIndex - 1].url;
      preArticle = await fetchArticle(articleId);
    } else {
      preArticle = null;
    }
    //获取下一章节
    if (this.widget.chapterIndex <= this.widget.chapters.length) {
      articleId = this.widget.chapters[this.widget.chapterIndex + 1].url;
      nextArticle = await fetchArticle(articleId);
    } else {
      nextArticle = null;
    }
    if (jumpType == PageJumpType.firstPage) {
      pageIndex = 0;
    } else if (jumpType == PageJumpType.lastPage) {
      pageIndex = currentArticle.pageCount - 1;
    }
    if (jumpType != PageJumpType.stay) {
      pageController.jumpToPage(
          (preArticle != null ? preArticle.pageCount : 0) + pageIndex);
    }

    setState(() {});
  }
}
