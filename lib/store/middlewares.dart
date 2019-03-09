import 'dart:async';
import 'dart:convert';

import 'package:chinese_words/models.dart';
import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';

import 'actions.dart';
import 'state.dart';

Stream<dynamic> initializeLessons(
        Stream<InitializeLessonsAction> actions, EpicStore<AppState> store) =>
    actions.asyncMap((action) => _loadLessons()
        .then((lessons) => LoadLessonsAction(lessons))
        .catchError((error) => LoadErrorAction(error)));

Future<List<Lesson>> _loadLessons() async {
  final response = await http.get('http://144.202.60.177/output.json');
  return (jsonDecode(response.body) as List)
      .map((obj) => Lesson.fromJson(obj))
      .toList();
}

final initializeLessonEpic =
    TypedEpic<AppState, InitializeLessonsAction>(initializeLessons);
final appMiddleware = EpicMiddleware<AppState>(initializeLessonEpic);
