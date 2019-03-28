import 'package:chinese_words/models/models.dart';

class FetchCollectionsAction {}

class CheckTtsAvailabilityAction {}

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

class ChangeUseTtsAction {
  // if this is true, value is ignored
  final bool toggle;

  // toggle should be false to use this field
  final bool value;

  ChangeUseTtsAction({this.toggle, this.value});
}

class ChangeTtsAvailabilityAction {
  final bool isAvailable;

  ChangeTtsAvailabilityAction(this.isAvailable);
}

class ToggleLessonVisibilityAction {
  final String lessonId;

  ToggleLessonVisibilityAction(this.lessonId);
}
