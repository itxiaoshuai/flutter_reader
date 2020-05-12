import 'package:flutter/material.dart';
import 'package:flutterreader/res/colors.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutterreader/res/dimens.dart';
import 'package:flutterreader/utils/screen.dart';

class ReaderMenu extends StatefulWidget {
  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu> {
  static final double _addBookshelfWidth = 95;
  static final double _bottomHeight = 200;
  static final double _sImagePadding = 20;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _content = "";
  double _height = 0;
  double _bottomPadding = _bottomHeight;
  double _imagePadding = _sImagePadding;
  double _addBookshelfPadding = _addBookshelfWidth;
  int _duration = 200;
  double _spaceValue = 1.8;
  double _textSizeValue = 18;
  bool _isNighttime = false;
  bool _isAddBookshelf = false;
  String _title = "";
  double _offset = 0;
  ScrollController _controller;

  //顶部菜单
  Widget readerToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          0, MediaQueryData.fromWindow(window).padding.top, 0, 0),
      color: Colors.white,
      height: 44,
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            color: Colors.yellow,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          Expanded(child: Container()),
          Container(
            height: 44,
            color: Colors.red,
            width: 44,
            child: Icon(Icons.more_horiz),
          ),
          Container(
            height: 44,
            color: Colors.deepPurpleAccent,
            width: 44,
            child: Icon(Icons.music_note),
          ),
        ],
      ),
    );
  }

  buildBottomView() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
            child: Column(
              children: <Widget>[],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          setState(() {
            print('object');
            _bottomPadding == 0
                ? _bottomPadding = _bottomHeight
                : _bottomPadding = 0;
            _height == Dimens.titleHeight
                ? _height = 0
                : _height = Dimens.titleHeight;
            _imagePadding == 0
                ? _imagePadding = _sImagePadding
                : _imagePadding = 0;
            _addBookshelfPadding == 0
                ? _addBookshelfPadding = _addBookshelfWidth
                : _addBookshelfPadding = 0;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            AnimatedContainer(
              height: _height,
              duration: Duration(milliseconds: _duration),
              child: Container(
                height: Dimens.titleHeight,
                color: MyColors.contentBgColor,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
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
                            'img/icon_title_back.png',
                            width: 20,
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
            ),
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.fromLTRB(Dimens.leftMargin, 0, 0, 0),
              width: _sImagePadding * 2,
              height: _sImagePadding * 2,
              child: AnimatedPadding(
                duration: Duration(milliseconds: _duration),
                padding: EdgeInsets.fromLTRB(
                    _imagePadding, _imagePadding, _imagePadding, _imagePadding),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isNighttime = !_isNighttime;
                    });
                  },
                  child: Image.asset(
                    _isNighttime
                        ? "img/icon_content_daytime.png"
                        : "img/icon_content_nighttime.png",
                    height: 36,
                    width: 36,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: _bottomHeight,
              child: AnimatedPadding(
                duration: Duration(milliseconds: _duration),
                padding: EdgeInsets.fromLTRB(0, _bottomPadding, 0, 0),
                child: Container(
                  height: _bottomHeight,
                  padding: EdgeInsets.fromLTRB(Dimens.leftMargin, 20,
                      Dimens.rightMargin, Dimens.leftMargin),
                  color: MyColors.contentBgColor,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "字号",
                            style: TextStyle(
                                color: MyColors.contentColor,
                                fontSize: Dimens.textSizeM),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Image.asset(
                            "img/icon_content_font_small.png",
                            color: MyColors.white,
                            width: 28,
                            height: 18,
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                valueIndicatorColor: MyColors.textPrimaryColor,
                                inactiveTrackColor: MyColors.white,
                                activeTrackColor: MyColors.textPrimaryColor,
                                activeTickMarkColor: Colors.transparent,
                                inactiveTickMarkColor: Colors.transparent,
                                trackHeight: 2.5,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: _textSizeValue,
                                label: "字号：$_textSizeValue",
                                divisions: 20,
                                min: 10,
                                max: 30,
                                onChanged: (double value) {
                                  setState(() {
                                    _textSizeValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Image.asset(
                            "img/icon_content_font_big.png",
                            color: MyColors.white,
                            width: 28,
                            height: 18,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "间距",
                            style: TextStyle(
                                color: MyColors.contentColor,
                                fontSize: Dimens.textSizeM),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Image.asset(
                            "img/icon_content_space_big.png",
                            color: MyColors.white,
                            width: 28,
                            height: 18,
                          ),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                valueIndicatorColor: MyColors.textPrimaryColor,
                                inactiveTrackColor: MyColors.white,
                                activeTrackColor: MyColors.textPrimaryColor,
                                activeTickMarkColor: Colors.transparent,
                                inactiveTickMarkColor: Colors.transparent,
                                trackHeight: 2.5,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: _spaceValue,
                                label: "字间距：$_spaceValue",
                                min: 1.0,
                                divisions: 20,
                                max: 3.0,
                                onChanged: (double value) {
                                  setState(() {
                                    _spaceValue = value;
                                  });
                                },
                                onChangeEnd: (value) {},
                              ),
                            ),
                          ),
                          Image.asset(
                            "img/icon_content_space_small.png",
                            color: MyColors.white,
                            width: 28,
                            height: 18,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("openDrawer");
                              _scaffoldKey.currentState.openDrawer();
                            },
                            child: Image.asset(
                              "img/icon_content_catalog.png",
                              height: 50,
                            ),
                          ),
                          Image.asset(
                            "img/icon_content_setting.png",
                            height: 50,
                          ),
                          Image.asset(
                            "img/icon_content_brightness.png",
                            height: 50,
                          ),
                          Image.asset(
                            "img/icon_content_read.png",
                            height: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
