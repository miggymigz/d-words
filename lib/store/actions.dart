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

class ChangeLessonSelectionAction {
  final String lessonId;
  final bool selected;

  ChangeLessonSelectionAction(this.lessonId, this.selected);
}

class ChangeQuizTypeAction {
  final QuizType quizType;

  ChangeQuizTypeAction(this.quizType);
}
