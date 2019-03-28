import 'package:chinese_words/models/models.dart';

import 'package:chinese_words/store/reducers/state.dart';

List<Collection> collectionsSelector(AppState state) => state.collections;

Set<String> selectedLessonIdsSelector(AppState state) =>
    state.selectedLessonIds;

Set<String> hiddenLessonIdsSelector(AppState state) => state.hiddenLessonIds;

QuizType quizTypeSelector(AppState state) => state.quizType;

bool isLoadingSelector(AppState state) => state.isLoading;

bool useTtsSelector(AppState state) => state.useTts;

bool ttsAvailableSelector(AppState state) => state.ttsAvailable;

/// Returns a list of collection that contains visible lessons
/// (e.g., not hidden by the user; collection is not included
/// if all of its lessons are hidden; lessons inside the collection
/// are also filtered so that only visible lessons are included).
List<Collection> visibleCollectionsSelector(
  List<Collection> collections,
  Set<String> hiddenLessonIds,
) =>
    collections
        .where((collection) => _hasVisibleLessons(collection, hiddenLessonIds))
        .map((collection) => collection.copyWith(
            lessons:
                _filterVisibleLessons(collection.lessons, hiddenLessonIds)))
        .toList();

/// Returns a list of collection that contains hidden lessons (collection
/// is not included if none of its lessons are hidden; lessons inside the
/// collection are also filtered so that only hidden lessons are included).
List<Collection> hiddenCollectionsSelector(
  List<Collection> collections,
  Set<String> hiddenLessonIds,
) =>
    collections
        .where((collection) => _hasHiddenLessons(collection, hiddenLessonIds))
        .map((collection) => collection.copyWith(
            lessons: _filterHiddenLessons(collection.lessons, hiddenLessonIds)))
        .toList();

/// Returns true if the given collection has at least one visible lesson.
bool _hasVisibleLessons(
  Collection collection,
  Set<String> hiddenLessonIds,
) =>
    collection.lessons.any((lesson) => !hiddenLessonIds.contains(lesson.id));

/// Returns true if the given collection has at least one hidden lesson.
bool _hasHiddenLessons(
  Collection collection,
  Set<String> hiddenLessonIds,
) =>
    collection.lessons.any((lesson) => hiddenLessonIds.contains(lesson.id));

/// Returns a list of visible lessons.
List<Lesson> _filterVisibleLessons(
  List<Lesson> lessons,
  Set<String> hiddenLessonIds,
) =>
    lessons.where((lesson) => !hiddenLessonIds.contains(lesson.id)).toList();

/// Returns a list of hidden lessons.
List<Lesson> _filterHiddenLessons(
  List<Lesson> lessons,
  Set<String> hiddenLessonIds,
) =>
    lessons.where((lesson) => hiddenLessonIds.contains(lesson.id)).toList();
