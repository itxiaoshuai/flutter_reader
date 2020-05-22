import 'package:flutterreader/entity/base.dart';

class BookDetail {
  /// http://api.pingcc.cn/?xsurl1=qbxshttps://www.x23qb.com/book/12893/
  int code;
  String message;
  List<ChapterList> list;

  static BookDetail fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookDetail bookDetail = BookDetail();
    bookDetail.code = map['code'];
    bookDetail.message = map['message'];
    bookDetail.list = List()
      ..addAll((map['list'] as List ?? []).map((o) => ChapterList.fromMap(o)));

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

class ChapterList {
  String num;
  String url;

  static ChapterList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ChapterList book = ChapterList();
    if (map['num'] != null) {
      book.num = map['num'];
    }
    if (map['url'] != null) {
      book.url = map['url'];
    }

    return book;
  }

  Map toJson() => {
        "num": num,
        "url": url,
      };
}
