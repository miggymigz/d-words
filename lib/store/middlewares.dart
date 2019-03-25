import 'dart:async';
import 'dart:convert';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'package:chinese_words/models.dart';

import 'actions.dart';
import 'state.dart';

const resourceUrl = 'https://gitee.com/miggymigz/words/raw/master/v2.json';

Stream<dynamic> _fetchCollectionsStream(
  Stream<FetchCollectionsAction> actions,
  EpicStore<AppState> store,
) =>
    Observable(actions).exhaustMap((action) =>
        Observable.fromFuture(_fetchCollections())
            .map((collections) => LoadCollectionsAction(collections))
            .handleError((error) => LoadErrorAction(error)));

Stream<dynamic> _checkTtsAvailabilityStream(
  Stream<CheckTtsAvailabilityAction> actions,
  EpicStore<AppState> store,
) =>
    Observable(actions).exhaustMap((action) =>
        Observable.fromFuture(FlutterTts().isLanguageAvailable('zh-CN'))
            .map((isAvailable) => ChangeTtsAvailabilityAction(isAvailable))
            .handleError((error) => LoadErrorAction(error)));

Future<List<Collection>> _fetchCollections() async {
  final response = await http.get(resourceUrl);
  return (jsonDecode(response.body) as List)
      .map((obj) => Collection.fromJson(obj))
      .toList();
}

final _fetchCollectionsEpic =
    TypedEpic<AppState, FetchCollectionsAction>(_fetchCollectionsStream);
final _checkTtsAvailabilityEpic =
    TypedEpic<AppState, CheckTtsAvailabilityAction>(
        _checkTtsAvailabilityStream);
final epics = EpicMiddleware<AppState>(
    combineEpics<AppState>([_fetchCollectionsEpic, _checkTtsAvailabilityEpic]));
