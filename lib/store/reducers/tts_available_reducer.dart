import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';

final ttsAvailableReducer = combineReducers<bool>([
  TypedReducer<bool, ChangeTtsAvailabilityAction>(_changeTtsAvailability),
]);

bool _changeTtsAvailability(
  bool state,
  ChangeTtsAvailabilityAction action,
) =>
    action.isAvailable;
