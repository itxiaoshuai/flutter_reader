import 'package:flutter/material.dart';
import 'package:flutterreader/data/response/article.dart';
import 'package:flutterreader/res/colors.dart';
import 'package:flutterreader/utils/screen.dart';
import 'package:flutterreader/utils/utility.dart';
import 'package:intl/intl.dart';

class ReaderOverlayer extends StatelessWidget {
  final Article article;
  final int page;
  final double topSafeHeight;

  ReaderOverlayer({this.article, this.page, this.topSafeHeight});
  @override
  Widget build(BuildContext context) {
    var format = DateFormat('HH:mm');
    var time = format.format(DateTime.now());
    return Container(
      padding: EdgeInsets.fromLTRB(
          15, 10 + topSafeHeight, 15, 10 + Screen.bottomSafeHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.num,
              style: TextStyle(
                  fontSize: fixedFontSize(14), color: MyColors.golden)),
          Expanded(child: Container()),
          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text(time,
                  style: TextStyle(
                      fontSize: fixedFontSize(11), color: MyColors.golden)),
              Expanded(child: Container()),
              Text('第${page + 1}页',
                  style: TextStyle(
                      fontSize: fixedFontSize(11), color: MyColors.golden)),
            ],
          ),
        ],
      ),
    );
  }
}
