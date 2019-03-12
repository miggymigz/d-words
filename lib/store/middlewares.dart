import 'dart:async';
import 'dart:convert';

import 'package:chinese_words/models.dart';
import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'actions.dart';
import 'state.dart';

const resourceUrl = 'https://gitee.com/miggymigz/words/raw/master/output.json';

Stream<dynamic> fetchLessons(
  Stream<FetchLessonsAction> actions,
  EpicStore<AppState> store,
) =>
    Observable(actions).exhaustMap((action) =>
        Observable.fromFuture(_fetchLessons())
            .map((lessons) => LoadLessonsAction(lessons))
            .handleError((error) => LoadErrorAction(error)));

Future<List<Lesson>> _fetchLessons() async {
  final response = await http.get(resourceUrl);
  return (jsonDecode(response.body) as List)
      .map((obj) => Lesson.fromJson(obj))
      .toList();
}

final fetchLessonsEpic = TypedEpic<AppState, FetchLessonsAction>(fetchLessons);
final appMiddleware = EpicMiddleware<AppState>(fetchLessonsEpic);
