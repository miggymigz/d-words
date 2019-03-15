import 'dart:async';
import 'dart:convert';

import 'package:chinese_words/models.dart';
import 'package:http/http.dart' as http;
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

import 'actions.dart';
import 'state.dart';

const resourceUrl = 'https://gitee.com/miggymigz/words/raw/master/v2.json';

Stream<dynamic> fetchCollections(
  Stream<FetchCollectionsAction> actions,
  EpicStore<AppState> store,
) =>
    Observable(actions).exhaustMap((action) =>
        Observable.fromFuture(_fetchCollections())
            .map((collections) => LoadCollectionsAction(collections))
            .handleError((error) => LoadErrorAction(error)));

Future<List<Collection>> _fetchCollections() async {
  final response = await http.get(resourceUrl);
  return (jsonDecode(response.body) as List)
      .map((obj) => Collection.fromJson(obj))
      .toList();
}

final fetchCollectionsEpic =
    TypedEpic<AppState, FetchCollectionsAction>(fetchCollections);
final appMiddleware = EpicMiddleware<AppState>(fetchCollectionsEpic);
