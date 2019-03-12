import 'package:flutter/material.dart';

import 'package:chinese_words/models.dart';

class WordDetails extends StatelessWidget {
  WordDetails(
    this.word, {
    this.showWord = true,
    this.showPinyin = true,
    this.showPartOfSpeech = true,
    this.showDefinition = true,
  });

  final Word word;
  final bool showWord;
  final bool showPinyin;
  final bool showPartOfSpeech;
  final bool showDefinition;

  static const wordStyle = TextStyle(fontSize: 86);
  static const pinyinStyle = TextStyle(fontSize: 24);
  static const partOfSpeechStyle =
      TextStyle(fontStyle: FontStyle.italic, color: Colors.white70);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Opacity(
          opacity: showWord ? 1 : 0,
          child: Text(
            word.word,
            style: wordStyle,
            textAlign: TextAlign.center,
          ),
        ),
        Opacity(
          opacity: showPinyin ? 1 : 0,
          child: Text(word.pinyin, style: pinyinStyle),
        ),
        Opacity(
          opacity: showPartOfSpeech ? 1 : 0,
          child: Text(
            word.partOfSpeech + '词',
            style: partOfSpeechStyle,
          ),
        ),
        SizedBox(height: 15),
        Opacity(
          opacity: showDefinition ? 1 : 0,
          child: Text(
            word.definition.replaceAll('*', ''),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
