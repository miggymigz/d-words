import 'package:chinese_words/models.dart';

class FetchCollectionsAction {}

class LoadCollectionsAction {
  final List<Collection> collections;

  LoadCollectionsAction(this.collections);
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
