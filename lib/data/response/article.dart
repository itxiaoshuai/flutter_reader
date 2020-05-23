import 'package:flutterreader/entity/base.dart';

class Article {
  /// http://api.pingcc.cn/?xsurl2=kyg/3064/read_1.html
  int code;
  String message;
  String num;
  List<String> content;
  List<Map<String, int>> pageOffsets;
  String stringContent;
  String chapterName;
  static Article fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Article article = Article();
    article.code = map['code'];
    article.message = map['message'];
    article.num = map['num'];
    article.content = map['content'].cast<String>();
    return article;
  }

  String stringAtPageIndex(int index) {
    var offset = pageOffsets[index];
    return this.stringContent.substring(offset['start'], offset['end']);
  }

  int get pageCount {
    return pageOffsets.length;
  }

  String get pagearticle {
    return stringContent;
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'num': num,
      'content': content,
    };
  }
}
