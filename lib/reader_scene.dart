import 'package:epub/epub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutterreader/manager/resource_mananger.dart';
import 'package:flutterreader/res/colors.dart';
import 'package:flutterreader/res/dimens.dart';
import 'package:flutterreader/utils/screen.dart';
import 'package:flutterreader/utils/utility.dart';
import 'package:flutterreader/res/img.dart';
import 'package:flutter/src/widgets/image.dart' deferred as img;
import 'main.dart';
import 'res/gaps.dart';

enum PageJumpType { stay, firstPage, lastPage }

class ReaderScene extends StatefulWidget {
  final EpubBook epubBook;

  ReaderScene({this.epubBook});

  @override
  ReaderSceneState createState() => ReaderSceneState();

  void onTap() {}
}

class ReaderSceneState extends State<ReaderScene>
    with TickerProviderStateMixin {
  PageController pageController = PageController(keepPage: false);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  bool isForward = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    curve = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget html = Html(
    data: epubBook.Chapters[3].SubChapters[0].HtmlContent,
    //Optional parameters:
    onLinkTap: (url) {
      // open url in a webview
    },
    style: {},
    onImageTap: (src) {
      // Display the image in large form.
    },
  );
  Widget buildPage(BuildContext context, int index) {
    return GestureDetector(
        child: Container(
      child: html,
//      child: Center(
//        child: Text.rich(
//          TextSpan(children: [
//            TextSpan(
//                text: epubBook.Chapters[1].HtmlContent,
//                style: TextStyle(fontSize: fixedFontSize(20)))
//          ]),
//          textAlign: TextAlign.justify,
//        ),
//      ),
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

  buildBottomView() {
    return Positioned(
      bottom: -(Screen.bottomSafeHeight + 110) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Container(
            color: MyColors.contentBgColor,
            padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
            child: Column(
              children: <Widget>[
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildBottomItem('目录', ConstImgResource.catalog),
        buildBottomItem('亮度', ConstImgResource.brightness),
        buildBottomItem('字体', ConstImgResource.font),
        buildBottomItem('设置', ConstImgResource.setting),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState.openDrawer();
        },
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(Dimens.leftMargin, 0, Dimens.rightMargin, 0),
          child: Container(
            width: 60,
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Column(
              children: <Widget>[
                img.Image.asset(
                  ImageHelper.wrapAssets(icon),
                  color: MyColors.white,
                ),
                SizedBox(height: 5),
                Text(title,
                    style: TextStyle(
                        fontSize: fixedFontSize(12), color: MyColors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildReadTopView() {
    return Positioned(
        top: -Screen.navigationBarHeight * (1 - animation.value),
        left: 0,
        right: 0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              height: Dimens.titleHeight,
              color: MyColors.contentBgColor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            Dimens.leftMargin, 0, Dimens.rightMargin, 0),
                        child: img.Image.asset(
                          ImageHelper.wrapAssets(ConstImgResource.back),
                          width: 30,
                          height: Dimens.titleHeight,
                          color: MyColors.contentColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: img.Image.asset(
                          ImageHelper.wrapAssets(ConstImgResource.more),
                          width: 3.0,
                          height: Dimens.titleHeight,
                          color: MyColors.contentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(child: ReadDrawer(epubBook)),
      body: AnnotatedRegion(
        value: SystemChrome.setEnabledSystemUIOverlays([]),
        child: GestureDetector(
            onTap: () {
              isForward
                  ? animationController.reverse()
                  : animationController.forward();
              isForward = !isForward;
            },
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
                buildReadTopView(),
                buildBottomView(),
              ],
            )),
      ),
    );
  }
}

Widget buildTwoRow() {
  return Row(
    //水平方向填充
    mainAxisSize: MainAxisSize.max,
    //平分空白
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Expanded(
        flex: 1,
        child: Container(
          height: 50,
          child: ListRowItem(image: ConstImgResource.dwn, text: "目录"),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          height: 50,
          child: ListRowItem(image: ConstImgResource.bookmark, text: "书签"),
        ),
      ),
      Expanded(
        flex: 1,
        child: Container(
          height: 50,
          child: ListRowItem(
            image: ConstImgResource.notes,
            text: "笔记",
            colors: Colors.yellow,
          ),
        ),
      ),
    ],
  );
}

class ListRowItem extends StatelessWidget {
  final String text;
  final String image;
  final MaterialColor colors;

  ListRowItem({this.image, this.text, this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          img.Image.asset(
            ImageHelper.wrapAssets(image),
            width: 20,
          ),
          Gaps.hGap4,
          Container(
              child: Text(text, style: TextStyle(fontSize: 16, color: colors)))
        ],
      ),
    );
  }
}

class ReadDrawer extends StatefulWidget {
  ReadDrawer(EpubBook epubBook, {Key key}) : super(key: key);

  @override
  _ReadDrawerState createState() => _ReadDrawerState();
}

class _ReadDrawerState extends State<ReadDrawer> {
  /// 初始化控制器
  PageController pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    epubBook.Chapters.forEach((EpubChapter chapter) {
      // Title of chapter
      String chapterTitle = chapter.Title;
      print(chapterTitle);
      // HTML content of current chapter
      String chapterHtmlContent = chapter.HtmlContent;
//      print(chapterHtmlContent);
      // Nested chapters
      List<EpubChapter> subChapters = chapter.SubChapters;
      subChapters.forEach((EpubChapter epubChapter) {
        String chapterTitle = epubChapter.Title;
        print(chapterTitle);
      });
    });

    ///创建控制器的实例
    pageController = new PageController(
      ///用来配置PageView中默认显示的页面 从0开始
      initialPage: _selectedIndex,

      ///为true是保持加载的每个页面的状态
      keepPage: true,
    );

    ///PageView设置滑动监听
    pageController.addListener(() {
      //PageView滑动的距离
      double offset = pageController.offset;
      print("pageView 滑动的距离 $offset");
    });
  }

  Widget buildTwoRow() {
    return Row(
      //水平方向填充
      mainAxisSize: MainAxisSize.max,
      //平分空白
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Material(
            child: InkWell(
              onTap: () {
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: Container(
                height: 50,
                child: ListRowItem(
                  image: _selectedIndex == 0
                      ? ConstImgResource.dwnPressed
                      : ConstImgResource.dwn,
                  text: "目录",
                  colors: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Material(
            child: InkWell(
              onTap: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: Container(
                height: 50,
                child: ListRowItem(
                  image: _selectedIndex == 1
                      ? ConstImgResource.bookmarkPressed
                      : ConstImgResource.bookmark,
                  text: "书签",
                  colors: _selectedIndex == 1 ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Material(
              child: InkWell(
                onTap: () {
                  pageController.animateToPage(2,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear);
                },
                child: Container(
                  height: 50,
                  child: ListRowItem(
                    image: _selectedIndex == 2
                        ? ConstImgResource.notesPressed
                        : ConstImgResource.notes,
                    text: "笔记",
                    colors: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget buildListData(
    BuildContext context,
    EpubChapter epubChapter,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          height: 48,
          child: Row(
            children: [
              Text(
                epubChapter.Title,
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
        ListView.builder(
          itemCount: epubChapter.SubChapters.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Gaps.line,
                Container(
                  padding: EdgeInsets.only(left: 25),
                  height: 48,
                  child: Row(
                    children: [
                      Text(
                        epubChapter.SubChapters[index].Title,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget pageOne() {
    return Container(
      child: ListView.separated(
          itemBuilder: (context, item) {
            return buildListData(context, epubBook.Chapters[item]);
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.black,
                height: 0,
              ),
          itemCount: epubBook.Chapters.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            reverse: false,
            physics: BouncingScrollPhysics(),
            pageSnapping: true,
            onPageChanged: (index) {
              _selectedIndex = index;
              //监听事件
              print('index=====$index');
              setState(() {});
            },
            children: <Widget>[
              pageOne(),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    '第2页',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    '第3页',
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
          buildTwoRow(),
        ],
      ),
    );
  }
}
