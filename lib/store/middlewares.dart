import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:redux_epics/redux_epics.dart';
import 'package:chinese_words/models.dart';

import 'state.dart';
import 'actions.dart';

Stream<dynamic> initializeLessonsEpic(
        Stream<InitializeLessonsAction> actions, EpicStore<AppState> store) =>
    actions.asyncMap((action) => _loadLessons()
        .then((lessons) => LoadLessonsAction(lessons))
        .catchError((error) => LoadErrorAction(error)));

Future<List<Lesson>> _loadLessons() async {
  String lessonsJsonString = await rootBundle.loadString('assets/output.json');
  return (jsonDecode(lessonsJsonString) as List)
      .map((obj) => Lesson.fromJson(obj))
      .toList();
}

final epics =
    TypedEpic<AppState, InitializeLessonsAction>(initializeLessonsEpic);
final middlewares = EpicMiddleware<AppState>(epics);
