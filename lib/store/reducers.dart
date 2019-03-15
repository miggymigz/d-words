import 'state.dart';
import 'actions.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is LoadCollectionsAction) {
    return loadCollections(state, action);
  }

  if (action is ChangeLessonSelectionAction) {
    return changeLessonSelection(state, action);
  }

  if (action is ChangeQuizTypeAction) {
    return changeQuizType(state, action);
  }

  return state;
}

AppState loadCollections(AppState state, LoadCollectionsAction action) {
  return state.copyWith(collections: action.collections);
}

AppState changeLessonSelection(
    AppState state, ChangeLessonSelectionAction action) {
  final newSelectedLessonIds = Set<String>.from(state.selectedLessonIds);

  if (action.selected) {
    newSelectedLessonIds.add(action.lessonId);
  } else {
    newSelectedLessonIds.remove(action.lessonId);
  }

  return state.copyWith(selectedLessonIds: newSelectedLessonIds);
}

AppState changeQuizType(AppState state, ChangeQuizTypeAction action) =>
    state.copyWith(quizType: action.quizType);
