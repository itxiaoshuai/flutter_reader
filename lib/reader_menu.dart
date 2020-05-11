import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class ReaderMenu extends StatefulWidget {
  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (_) {},
            child: Container(color: Colors.transparent),
          ),
          readerToolbar(context),
        ],
      ),
    );
  }
}
