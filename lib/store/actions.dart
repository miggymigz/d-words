import 'package:chinese_words/models.dart';

class FetchLessonsAction {}

class LoadLessonsAction {
  final List<Lesson> lessons;

  LoadLessonsAction(this.lessons);
}

class LoadErrorAction {
  final Error error;

  LoadErrorAction(this.error);
}
