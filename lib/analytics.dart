import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

import 'package:chinese_words/models.dart';

const platform = const MethodChannel('com.example.chinese_words/events');

void quizStarted({
  @required QuizType quizType,
  @required Set<String> lessonIds,
}) =>
    trackEvent('Quiz Started', props: {
      'Type': quizType.toString(),
      'Lesson IDs': lessonIds.toString(),
    });

void refreshTapped() => trackEvent('Refresh Tapped');

void lessonViewed({@required Lesson lesson}) =>
    trackEvent('Lesson Viewed', props: {
      'ID': lesson.id,
      'Title': lesson.title,
      'Subtitle': lesson.subtitle,
    });

void trackEvent(String eventName, {Map<String, String> props}) async {
  if (props == null) {
    props = {};
  }

  props['eventName'] = eventName;

  try {
    await platform.invokeMethod('trackEvent', props);
  } on PlatformException catch (e) {
    print(e.toString());
  }
}
