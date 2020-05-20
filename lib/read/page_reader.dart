import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ReaderPage extends StatefulWidget {
  final String bookId;

  ReaderPage({this.bookId});

  @override
  ReaderPageState createState() => ReaderPageState();
}

class ReaderPageState extends State<ReaderPage> {
  @override
  void initState() {
    super.initState();
    init(widget.bookId);
  }

  init(String bookId) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get("https://novel.juhe.im/book/$bookId");
    print(response);
//    BookList bookList = BookList.fromMap(response.data);
    setState(() {
//      _list = bookList.books;
    });
//    print(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('阅读'),
      ),
    );
  }
}
