import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';

final hiddenLessonIdsReducer = combineReducers<Set<String>>([
  TypedReducer<Set<String>, ToggleLessonVisibilityAction>(
      _toggleLessonVisibility),
]);

Set<String> _toggleLessonVisibility(
  Set<String> state,
  ToggleLessonVisibilityAction action,
) =>
    state.contains(action.lessonId)
        ? (Set.from(state)..remove(action.lessonId))
        : (Set.from(state)..add(action.lessonId));
