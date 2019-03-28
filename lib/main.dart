import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'containers/containers.dart';
import 'core/localizations.dart';
import 'core/routes.dart';
import 'store/store.dart';

class WordsApp extends StatelessWidget {
  const WordsApp({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
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
        initialRoute: DWordsRoutes.lessons,
        routes: {
          DWordsRoutes.lessons: (context) => _buildLessonsScreen(context),
          DWordsRoutes.hiddenLessons: (context) => HiddenLessonsScreen(),
          DWordsRoutes.quizSettings: (context) => QuizSettingsScreen(),
        },
      ),
    );
  }

  Widget _buildLessonsScreen(BuildContext context) {
    return LessonsScreen(
      /// Dispatches all actions that are needed for the app to be functional
      ///
      /// FetchCollectionsAction makes sure that all of the data is fresh.
      /// CheckTtsAvailabilityAction checks if TTS is properly setup in a user's device.
      onInit: () {
        StoreProvider.of<AppState>(context)
          ..dispatch(FetchCollectionsAction())
          ..dispatch(CheckTtsAvailabilityAction());
      },
    );
  }
}

void main() async => runApp(WordsApp(store: await createStore()));
