import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterreader/manager/resource_mananger.dart';
import 'package:flutterreader/res/colors.dart';
import 'package:flutterreader/res/dimens.dart';
import 'package:flutterreader/utils/screen.dart';
import 'package:flutterreader/utils/utility.dart';
import 'package:flutterreader/res/img.dart';

import 'res/gaps.dart';

enum PageJumpType { stay, firstPage, lastPage }

class ReaderScene extends StatefulWidget {
  final int articleId;

  ReaderScene({this.articleId});

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

  Widget buildPage(BuildContext context, int index) {
    return GestureDetector(
        child: Container(
      child: Center(
        child: Text(index.toString()),
      ),
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
                Image.asset(
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
                        child: Image.asset(
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
                        child: Image.asset(
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
      drawer: Drawer(child: ReadDrawer()),
      body: AnnotatedRegion(
        value:
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
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
                    child: Image.asset(
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
          child: ListRowItem(image: ConstImgResource.notes, text: "笔记"),
        ),
      ),
    ],
  );
}

class ListRowItem extends StatelessWidget {
  final String text;
  final String image;

  ListRowItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            ImageHelper.wrapAssets(image),
            width: 20,
          ),
          Gaps.hGap4,
          Container(
              child: Text(text,
                  style: TextStyle(
                    fontSize: 16,
                  )))
        ],
      ),
    );
  }
}

class ReadDrawer extends StatefulWidget {
  @override
  _ReadDrawerState createState() => _ReadDrawerState();
}

class _ReadDrawerState extends State<ReadDrawer>
    with SingleTickerProviderStateMixin {
  TabController controller; //tab控制器
  int _currentIndex = 0; //选中下标
  @override
  void initState() {
    super.initState();
    //初始化controller并添加监听
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() => _onTabChanged());
  }

  ///
  /// tab改变监听
  ///
  _onTabChanged() {
    if (controller.index.toDouble() == controller.animation.value) {
      //赋值 并更新数据
      this.setState(() {
        _currentIndex = controller.index;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //DefaultTabController
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: TabBar(
              controller: TabController(length: 3, vsync: this)
                ..addListener(() {
                  print('xx');
                }),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              tabs: <Widget>[
                Tab(
                    icon: Icon(
                      Icons.directions_car,
                    ),
                    text: "目录"),
                Tab(icon: Icon(Icons.directions_transit), text: "书签"),
                Tab(icon: Icon(Icons.directions_bike), text: "笔记"),
//                Tab(
//                  child: ListRowItem(image: ConstImgResource.dwn, text: "目录"),
//                ),
//                Tab(
//                  child:
//                      ListRowItem(image: ConstImgResource.bookmark, text: "书签"),
//                ),
//                Tab(
//                  child: ListRowItem(image: ConstImgResource.notes, text: "笔记"),
//                ),
              ],
            )),
        body: TabBarView(
          children: <Widget>[
            Container(
              child: Text('xxx'), //TabCar对应tab_car.dart的Class name
            ),
            Container(
              child: Text('xxx'),
            ),
            Container(
              child: Text('xxx'),
            ),
          ],
        ),
      ),
    );
  }
}
