import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:chinese_words/store.dart';
import 'package:chinese_words/localizations.dart';

import 'lessons_list.dart';

class WordsApp extends StatelessWidget {
  const WordsApp({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: LessonsList(),
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        onGenerateTitle: (context) => AppLocalizations.of(context).app.title,
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ko', ''),
        ],
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.blueAccent,
          scaffoldBackgroundColor: Colors.black,
          toggleableActiveColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
