import 'dart:async';
import 'dart:convert';

import 'package:chinese_words/models.dart';
import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';

import 'actions.dart';
import 'state.dart';

const resourceUrl = 'https://gitee.com/miggymigz/words/raw/master/output.json';

Stream<dynamic> initializeLessons(
        Stream<FetchLessonsAction> actions, EpicStore<AppState> store) =>
    actions.asyncMap((action) => _loadLessons()
        .then((lessons) => LoadLessonsAction(lessons))
        .catchError((error) => LoadErrorAction(error)));

Future<List<Lesson>> _loadLessons() async {
  final response = await http.get(resourceUrl);
  return (jsonDecode(response.body) as List)
      .map((obj) => Lesson.fromJson(obj))
      .toList();
}

final initializeLessonEpic =
    TypedEpic<AppState, FetchLessonsAction>(initializeLessons);
final appMiddleware = EpicMiddleware<AppState>(initializeLessonEpic);
