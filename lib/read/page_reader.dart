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
import 'package:oktoast/oktoast.dart';

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
  double topSafeHeight = 0;
  Article preArticle; //前一章节
  Article currentArticle; //当前章节
  Article nextArticle; //下一章节
  int pageIndex = 0;
  int currentChapterIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentChapterIndex = widget.chapterIndex;
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: TextStyle(fontSize: 19.0, color: Colors.white),
      backgroundColor: Colors.grey,
      radius: 10.0,
      animationCurve: Curves.easeIn,
      animationBuilder: Miui10AnimBuilder(),
      animationDuration: Duration(milliseconds: 200),
      duration: Duration(seconds: 3),
      child: Scaffold(
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
      ),
    );
  }

  Widget buildPage(BuildContext context, int index) {
    print('index-------$index');
    print(preArticle.pageCount);
    print(currentArticle.pageCount);
    print(nextArticle.pageCount);
    var article;
    var page;
    if (index < preArticle.pageCount) {
      article = preArticle;
      page = index;
    } else if (index >= preArticle.pageCount &&
        index < (preArticle.pageCount + currentArticle.pageCount)) {
      article = currentArticle;
      page = index - (preArticle != null ? preArticle.pageCount : 0);
    } else if (index >= (preArticle.pageCount + currentArticle.pageCount)) {
      article = nextArticle;
      page = index -
          ((preArticle != null ? preArticle.pageCount : 0) +
              (currentArticle != null ? currentArticle.pageCount : 0));
    }

//
//    if (page >= this.currentArticle.pageCount) {
//      // 到达下一章了
//      article = nextArticle;
//      page = 0;
//    } else if (page < 0) {
//      // 到达上一章了
//      article = preArticle;
//      page = preArticle.pageCount - 1;
//    } else {
//      article = this.currentArticle;
//    }

    return GestureDetector(
      onTapUp: (TapUpDetails details) {
//        onTap(details.globalPosition);
      },
      child: ReaderView(
          article: article, page: page, topSafeHeight: topSafeHeight),
    );
  }

  onPageChanged(int index) {
    showToast(
      index.toString(),
      duration: Duration(milliseconds: 3500),
      position: ToastPosition.center,
      backgroundColor: Colors.black.withOpacity(0.8),
      radius: 3.0,
      textStyle: TextStyle(fontSize: 30.0),
    );
    var page = index - (preArticle != null ? preArticle.pageCount : 0);
    if (page < currentArticle.pageCount && page >= 0) {
      setState(() {
        pageIndex = page;
      });
    }
  }

  buildPageView() {
    if (currentArticle == null) {
      return Container();
    }
    int itemCount = (preArticle != null ? preArticle.pageCount : 0) +
        currentArticle.pageCount +
        (nextArticle != null ? nextArticle.pageCount : 0);
    print('itemCount---->$itemCount');
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: PageController(
          initialPage: preArticle != null ? preArticle.pageCount : 0)
        ..addListener(onScroll),
      itemCount: itemCount,
      itemBuilder: buildPage,
      onPageChanged: onPageChanged,
    );
  }

  Future<Article> fetchArticle(String articleId) async {
    Response response;
    Dio dio = Dio();
    print('http://api.pingcc.cn/?xsurl2=' + articleId);
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
    article.stringContent = stringContent;
    article.pageOffsets = ReaderPageAgent.getPageOffsets(article.stringContent,
        contentHeight, contentWidth, ReaderConfig.instance.fontSize);
//    print(article.pageOffsets);
    print(article.pageCount);
    return article;
  }

  Future<void> setup() async {
    await SystemChrome.setEnabledSystemUIOverlays([]);
    // 不延迟的话，安卓获取到的topSafeHeight是错的。
    await Future.delayed(const Duration(milliseconds: 100), () {});
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    topSafeHeight = Screen.topSafeHeight;
    await resetContent(this.widget.chapters[this.widget.chapterIndex].url,
        this.widget.chapterIndex, PageJumpType.stay);
  }

  resetContent(
      String articleId, int chapterIndex, PageJumpType jumpType) async {
    print('  //获取当前章节');
    currentArticle = await fetchArticle(articleId);
    //获取前一章节
    if (this.widget.chapterIndex > 0) {
      print('  //获取前一章节');
      articleId = this.widget.chapters[currentChapterIndex - 1].url;
      preArticle = await fetchArticle(articleId);
    } else {
      preArticle = null;
    }
    //获取下一章节
    if (this.widget.chapterIndex <= this.widget.chapters.length) {
      print('  //获取下一章节');
      articleId = this.widget.chapters[currentChapterIndex + 1].url;
      nextArticle = await fetchArticle(articleId);
    } else {
      nextArticle = null;
    }
//    if (jumpType == PageJumpType.firstPage) {
//      pageIndex = 0;
//    } else if (jumpType == PageJumpType.lastPage) {
//      pageIndex = currentArticle.pageCount - 1;
//    }
//    if (jumpType != PageJumpType.stay) {
//      pageController.jumpToPage(
//          (preArticle != null ? preArticle.pageCount : 0) + pageIndex);
//    }

    setState(() {});
  }

  onScroll() {
//    double offset = pageController.offset;
//    print('pageController.offset$offset');
//    var page = pageController.offset / Screen.width;
//    print('page----------->$page');
//    var nextArtilePage = currentArticle.pageCount +
//        (preArticle != null ? preArticle.pageCount : 0);
//
//    if (page >= nextArtilePage) {
//      currentChapterIndex = currentChapterIndex + 1;
//      print('到达下个章节了---$currentChapterIndex');
//      preArticle = currentArticle;
//      currentArticle = nextArticle;
//      nextArticle = null;
//      pageIndex = 0;
//      pageController.jumpToPage(preArticle.pageCount);
//
//      if (currentChapterIndex <= this.widget.chapters.length) {
//        String articleId = this.widget.chapters[currentChapterIndex + 1].url;
//        fetchNextArticle(articleId);
//      }
//
//      setState(() {});
//    }
//    if (preArticle != null && page <= preArticle.pageCount - 1) {
//      currentChapterIndex = currentChapterIndex - 1;
//      print('到达上个章节了---$currentChapterIndex');
//      nextArticle = currentArticle;
//      currentArticle = preArticle;
//      preArticle = null;
//      pageIndex = currentArticle.pageCount - 1;
//      pageController.jumpToPage(currentArticle.pageCount - 1);
//      if (currentChapterIndex > 0) {
//        String articleId = this.widget.chapters[currentChapterIndex].url;
//        fetchPreviousArticle(articleId);
//      }
//
//      setState(() {});
//    }
  }

  Future<void> fetchNextArticle(articleId) async {
    if (nextArticle != null || isLoading || articleId == 0) {
      return;
    }
    isLoading = true;
    nextArticle = await fetchArticle(articleId);
    isLoading = false;
    setState(() {});
  }

  Future<void> fetchPreviousArticle(articleId) async {
    if (preArticle != null || isLoading || articleId == 0) {
      return;
    }
    isLoading = true;
    preArticle = await fetchArticle(articleId);
    isLoading = false;
    setState(() {});
  }
}
