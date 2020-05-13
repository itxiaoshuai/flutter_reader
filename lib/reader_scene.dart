import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterreader/reader_menu.dart';
import 'package:flutterreader/res/colors.dart';
import 'package:flutterreader/res/dimens.dart';
import 'package:flutterreader/utils/screen.dart';
import 'package:flutterreader/utils/utility.dart';

import 'res/styles.dart';

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
        buildBottomItem('目录', 'img/read_icon_catalog.png'),
        buildBottomItem('亮度', 'img/read_icon_brightness.png'),
        buildBottomItem('字体', 'img/read_icon_font.png'),
        buildBottomItem('设置', 'img/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
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
                  icon,
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
                          'img/reader_toolbar_top_back.png',
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
                          'img/icon_bookshelf_more.png',
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
      body: AnnotatedRegion(
        value:
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]),
        child: GestureDetector(
            onTap: () {
              print('object;');
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
                    child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
                buildPageView(),
                buildReadTopView(),
                buildBottomView(),
              ],
            )),
      ),
    );
  }
}
