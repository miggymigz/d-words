import 'package:chinese_words/models.dart';

class AppState {
  final List<Lesson> lessons;
  final Set<int> selectedLessons;

  AppState({this.lessons, this.selectedLessons});

  factory AppState.initial() =>
      AppState(lessons: List.unmodifiable([]), selectedLessons: {});

  AppState copyWith({List<Lesson> lessons, Set<int> selectedLessons}) =>
      AppState(
          lessons: lessons ?? this.lessons,
          selectedLessons: selectedLessons ?? this.selectedLessons);
}
