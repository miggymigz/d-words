import 'package:flutter/material.dart';

import 'package:chinese_words/models.dart';

class WordsList extends StatelessWidget {
  const WordsList({Key key, this.title, this.lesson}) : super(key: key);

  final String title;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title), elevation: 0),
        body: ListView.builder(
            itemCount: lesson.words.length, itemBuilder: _buildRow));
  }

  Widget _buildRow(BuildContext context, int index) {
    final word = lesson.words[index];
    final title = word.word + ' ' + word.pinyin;

    return ListTile(
      key: Key(word.word),
      title: Text(title),
      subtitle: Text(word.definition),
      trailing: Text(word.partOfSpeech),
      onTap: () {},
    );
  }
}
