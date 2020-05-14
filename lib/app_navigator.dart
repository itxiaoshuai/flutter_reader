import 'package:epub/epub.dart';
import 'package:flutter/material.dart';
import 'package:flutterreader/reader_scene.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static pushReader(BuildContext context, EpubBook epubBook) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReaderScene(epubBook: epubBook);
    }));
  }
}
