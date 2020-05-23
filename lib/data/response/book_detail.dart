import 'package:flutterreader/entity/base.dart';

class BookDetail {
  /// http://api.pingcc.cn/?xsurl1=qbxshttps://www.x23qb.com/book/12893/
  int code;
  String message;
  List<Chapter> list;

  static BookDetail fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookDetail bookDetail = BookDetail();
    bookDetail.code = map['code'];
    bookDetail.message = map['message'];
    bookDetail.list = List()
      ..addAll((map['list'] as List ?? []).map((o) => Chapter.fromMap(o)));

    return bookDetail;
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'list': list,
    };
  }
}

class Chapter {
  String num;
  String url;

  static Chapter fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Chapter chapter = Chapter();
    if (map['num'] != null) {
      chapter.num = map['num'];
    }
    if (map['url'] != null) {
      chapter.url = map['url'];
    }

    return chapter;
  }

  Map toJson() => {
        "num": num,
        "url": url,
      };
}
