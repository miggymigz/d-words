import 'package:chinese_words/models.dart';

class InitializeLessonsAction {}

class LoadLessonsAction {
  final List<Lesson> lessons;

  LoadLessonsAction(this.lessons);
}

class LoadErrorAction {
  final Error error;

  LoadErrorAction(this.error);
}
