import 'state.dart';
import 'actions.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is LoadLessonsAction) {
    return loadLessons(state, action);
  }

  if (action is ChangeLessonSelectionAction) {
    return changeLessonSelection(state, action);
  }

  return state;
}

AppState loadLessons(AppState state, LoadLessonsAction action) {
  return state.copyWith(lessons: action.lessons);
}

AppState changeLessonSelection(
    AppState state, ChangeLessonSelectionAction action) {
  final newSelectedLessons = Set<int>.from(state.selectedLessons);

  if (action.selected) {
    newSelectedLessons.add(action.order);
  } else {
    newSelectedLessons.remove(action.order);
  }

  return state.copyWith(selectedLessons: newSelectedLessons);
}
