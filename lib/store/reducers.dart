import 'state.dart';
import 'actions.dart';

AppState appReducers(AppState state, dynamic action) {
  if (action is LoadLessonsAction) {
    return loadLessons(state, action);
  }

  return state;
}

AppState loadLessons(AppState state, LoadLessonsAction action) {
  return state.copyWith(lessons: action.lessons);
}
