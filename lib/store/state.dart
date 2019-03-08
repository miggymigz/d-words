import 'package:chinese_words/models.dart';

class AppState {
  final List<Lesson> lessons;

  AppState(this.lessons);

  factory AppState.initial() => AppState(List.unmodifiable([]));
}
