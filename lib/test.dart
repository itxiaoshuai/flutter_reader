import 'dart:typed_data';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<Uint8List> _loadFromAssets(String assetName) async {
  final bytes = await rootBundle.load(assetName);
  return bytes.buffer.asUint8List();
}

EpubReaderController _epubReaderController;
Future<Uint8List> _bookContent;

@override
void initState() {
  _epubReaderController = EpubReaderController();
  _bookContent = _loadFromAssets('assets/book.epub');
}

@override
Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        // Show actual chapter name
        title: EpubActualChapter(
          controller: _epubReaderController,
          builder: (chapterValue) => Text(
            'Chapter ${chapterValue.chapter.Title ?? ''}',
            textAlign: TextAlign.start,
          ),
        ),
      ),
      // Show table of contents
      drawer: Drawer(
        child: EpubReaderTableOfContents(
          controller: _epubReaderController,
        ),
      ),
      // Show epub document
      body: FutureBuilder<Uint8List>(
        future: _bookContent,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return EpubReaderView.fromBytes(
              controller: _epubReaderController,
              bookData: snapshot.data,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
