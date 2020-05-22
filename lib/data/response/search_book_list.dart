import 'package:flutterreader/entity/base.dart';

class SearchBookList {
  /// http://api.pingcc.cn/?xsname=灵气逼人
  int code;
  String message;
  List<Book> list;

  static SearchBookList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SearchBookList bookList = SearchBookList();
    bookList.code = map['code'];
    bookList.message = map['message'];
    bookList.list = List()
      ..addAll((map['list'] as List ?? []).map((o) => Book.fromMap(o)));

    return bookList;
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'list': list,
    };
  }
}

class Book {
  String name;
  String url;
  String cover;
  String introduce;
  String num;
  String tag;
  String author;

  static Book fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Book book = Book();
    if (map['name'] != null) {
      book.name = map['name'];
    }
    if (map['url'] != null) {
      book.url = map['url'];
    }
    if (map['cover'] != null) {
      book.cover = map['cover'];
    }
    if (map['introduce'] != null) {
      book.introduce = map['introduce'];
    }
    if (map['tag'] != null) {
      book.tag = map['tag'];
    }
    if (map['author'] != null) {
      book.author = map['author'];
    }

    return book;
  }

  Map toJson() => {
        "name": name,
        "url": url,
        "cover": cover,
        "introduce": introduce,
        "num": num,
        "tag": tag,
        "author": author,
      };
}
