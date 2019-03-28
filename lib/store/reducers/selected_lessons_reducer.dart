import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';

final selectedLessonIdsReducer = combineReducers<Set<String>>([
  TypedReducer<Set<String>, ChangeLessonSelectionAction>(
      _changeLessonSelection),
]);

Set<String> _changeLessonSelection(
  Set<String> state,
  ChangeLessonSelectionAction action,
) =>
    action.selected
        ? (Set.from(state)..add(action.lessonId))
        : (Set.from(state)..remove(action.lessonId));
