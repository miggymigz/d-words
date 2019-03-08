import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'words/app.dart';
import 'store.dart';

void main() {
  final store = Store<AppState>(appReducers,
      initialState: AppState.initial(), middleware: [middlewares]);

  // dispatch action to initialize lessons from assets
  store.dispatch(InitializeLessonsAction());

  runApp(WordsApp(title: 'Chinese Words', store: store));
}
