import 'package:flutterreader/entity/base.dart';

class BookList extends Base {
  /// https://novel.juhe.im/books
  String total;
  List<Book> books;

  static BookList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BookList bookList = BookList();
    bookList.total = map['total'];
    bookList.books = List()
      ..addAll((map['books'] as List ?? []).map((o) => Book.fromMap(o)));

    return bookList;
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'books': books,
    };
  }
}

class Book {
  String bookId;
  String title;
  String author;
  String shortIntro;
  String cover;
  String cat;
  String zt;
  String updated;
  String lastChapter;

  static Book fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Book book = Book();
    book.bookId = map['_id'];
    book.title = map['title'];
    book.author = map['author'];
    book.shortIntro = map['shortIntro'];
    book.cover = map['cover'];
    book.lastChapter = map['lastChapter'];
    return book;
  }

  Map toJson() => {
        "_id": bookId,
        "title": title,
        "author": author,
        "shortIntro": shortIntro,
        "cover": cover,
        "cat": cat,
        "zt": zt,
        "updated": updated,
        "lastChapter": lastChapter,
      };
}
