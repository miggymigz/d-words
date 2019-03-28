import 'package:flutter/material.dart';

import 'package:chinese_words/models/models.dart';
import 'package:chinese_words/widgets/widgets.dart' as widgets;

class WordDetails extends StatelessWidget {
  const WordDetails({Key key, this.word}) : super(key: key);

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blueAccent),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: widgets.WordDetails(word),
        ),
      ),
    );
  }
}
