import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';

final useTtsReducer = combineReducers<bool>([
  TypedReducer<bool, ChangeUseTtsAction>(_changeUseTts),
]);

bool _changeUseTts(bool state, ChangeUseTtsAction action) =>
    action.toggle != null && action.toggle ? !state : action.value;
