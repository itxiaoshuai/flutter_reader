import 'package:flutterreader/entity/base.dart';

class BookChapterContent {
  /// http://api.pingcc.cn/?xsurl2=kyg/3064/read_1.html
  int code;
  String message;
  String num;
  List<String> content;

  static BookChapterContent fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookChapterContent bookChapterContent = BookChapterContent();
    bookChapterContent.code = map['code'];
    bookChapterContent.message = map['message'];
    bookChapterContent.num = map['num'];
    bookChapterContent.content = map['content'].cast<String>();

    return bookChapterContent;
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
