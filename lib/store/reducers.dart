import 'state.dart';
import 'actions.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is InitializeLessonsAction) {
    return initializeLessons(state, action);
  }

  if (action is LoadLessonsAction) {
    return loadLessons(state, action);
  }

  if (action is SelectLessonAction) {
    return selectLesson(state, action);
  }

  if (action is UnselectLessonAction) {
    return unselectLesson(state, action);
  }

  return state;
}

AppState initializeLessons(AppState state, InitializeLessonsAction action) {
  return state;
}

AppState loadLessons(AppState state, LoadLessonsAction action) {
  return AppState(action.lessons, state.selectedLessons);
}

AppState selectLesson(AppState state, SelectLessonAction action) {
  final Set<int> selectedLessons = Set<int>.from(state.selectedLessons)
    ..add(action.order);
  return AppState(state.lessons, selectedLessons);
}

AppState unselectLesson(AppState state, UnselectLessonAction action) {
  final Set<int> selectedLessons = Set<int>.from(state.selectedLessons)
    ..remove(action.order);
  return AppState(state.lessons, selectedLessons);
}
