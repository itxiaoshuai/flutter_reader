import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterreader/reader_menu.dart';

enum PageJumpType { stay, firstPage, lastPage }

class ReaderScene extends StatefulWidget {
  final int articleId;

  ReaderScene({this.articleId});

  @override
  ReaderSceneState createState() => ReaderSceneState();
}

class ReaderSceneState extends State<ReaderScene> {
  PageController pageController = PageController(keepPage: false);

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
                child: Image.asset('img/read_bg.png', fit: BoxFit.cover)),
            buildPageView(),
            ReaderMenu(),
//            buildMenu(),
          ],
        ),
      ),
    );
  }
}
