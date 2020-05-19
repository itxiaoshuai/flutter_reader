import 'package:flutterreader/entity/base.dart';

class CategoriesResp extends Base {
  /// http://api.zhuishushenqi.com/book/by-categories?gender=male&type=new&major=%E7%8E%84%E5%B9%BB&minor=&start=0&limit=20
  int total;
  List<Book> books;
  static CategoriesResp fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CategoriesResp categoriesResp = CategoriesResp();
    categoriesResp.total = map['total'];
    categoriesResp.books = List()
      ..addAll((map['books'] as List ?? []).map((o) => Book.fromMap(o)));

    return categoriesResp;
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'books': books,
    };
  }
}

class Book {
  String _id;
  String title;
  String author;
  String shortIntro;
  String majorCate;
  String minorCate;
  String cover;
  String site;
  String superscript;
  String contentType;
  bool allowMonthly;
  int latelyFollower;
  double retentionRatio;
  String lastChapter;
  List<String> tags;

  static Book fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Book book = Book();
    book._id = map['_id'];
    book.title = map['title'];
    book.author = map['author'];
    book.shortIntro = map['shortIntro'];
    book.majorCate = map['majorCate'];
    book.minorCate = map['minorCate'];
    book.cover = map['cover'];
    book.site = map['site'];
    book.contentType = map['contentType'];
    book.allowMonthly = map['allowMonthly'];
    book.latelyFollower = map['latelyFollower'];
    book.retentionRatio = map['retentionRatio'];
    book.lastChapter = map['lastChapter'];
    book.tags = map['tags'].cast<String>();
    return book;
  }

  Map toJson() => {
        "_id": _id,
        "title": title,
        "author": author,
        "shortIntro": shortIntro,
        "majorCate": majorCate,
        "minorCate": minorCate,
        "cover": cover,
        "site": site,
        "contentType": contentType,
        "allowMonthly": allowMonthly,
        "retentionRatio": retentionRatio,
        "lastChapter": lastChapter,
        "tags": tags,
      };
}
