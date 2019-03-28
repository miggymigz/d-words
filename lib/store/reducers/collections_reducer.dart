import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';
import 'package:chinese_words/models/models.dart';

final collectionsReducer = combineReducers<List<Collection>>([
  TypedReducer<List<Collection>, LoadCollectionsAction>(_loadCollections),
]);

List<Collection> _loadCollections(
  List<Collection> state,
  LoadCollectionsAction action,
) {
  return action.collections;
}
