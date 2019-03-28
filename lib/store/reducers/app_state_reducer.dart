import 'collections_reducer.dart';
import 'hidden_lessons_reducer.dart';
import 'is_loading_reducer.dart';
import 'quiz_type_reducer.dart';
import 'selected_lessons_reducer.dart';
import 'state.dart';
import 'tts_available_reducer.dart';
import 'use_tts_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    collections: collectionsReducer(state.collections, action),
    selectedLessonIds:
        selectedLessonIdsReducer(state.selectedLessonIds, action),
    hiddenLessonIds: hiddenLessonIdsReducer(state.hiddenLessonIds, action),
    quizType: quizTypeReducer(state.quizType, action),
    isLoading: isLoadingReducer(state.isLoading, action),
    useTts: useTtsReducer(state.useTts, action),
    ttsAvailable: ttsAvailableReducer(state.ttsAvailable, action),
  );
}
