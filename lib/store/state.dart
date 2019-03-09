import 'package:chinese_words/models.dart';

class AppState {
  final List<Lesson> lessons;
  final Set<int> selectedLessons;

  AppState(this.lessons, this.selectedLessons);

  factory AppState.initial() => AppState(List.unmodifiable([]), {});
}
