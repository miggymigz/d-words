import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:chinese_words/store.dart';

import 'lessons_list.dart';

class WordsApp extends StatelessWidget {
  const WordsApp({Key key, this.title, this.store}) : super(key: key);

  final String title;
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: title,
        theme: ThemeData.dark().copyWith(accentColor: Colors.blueAccent),
        home: LessonsList(title: 'Words'),
      ),
    );
  }
}
