import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';

final isLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, FetchCollectionsAction>(_fetchCollections),
  TypedReducer<bool, LoadCollectionsAction>(_loadCollections),
]);

bool _fetchCollections(
  bool state,
  FetchCollectionsAction action,
) =>
    true;

bool _loadCollections(
  bool state,
  LoadCollectionsAction action,
) =>
    false;
