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
    // some words doesn't have part of speech
    // and it shouldn't be displayed if it isn't given
    final shouldShowPartOfSpeech = word.partOfSpeech != '' && showPartOfSpeech;

    // properly build part of speech
    // e.g., if a word has multiple part of speech,
    // each part of speech should have 词 at the end (except 成)
    final partOfSpeech = word.partOfSpeech
        .split('、')
        .map((pos) => pos == '成' ? pos + '语' : pos + '词')
        .join('、');

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
          opacity: shouldShowPartOfSpeech ? 1 : 0,
          child: Text(
            partOfSpeech,
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
