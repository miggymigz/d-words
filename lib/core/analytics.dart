import 'package:meta/meta.dart';
import 'package:flutter/services.dart';

import 'package:chinese_words/models/models.dart';

const platform = const MethodChannel('io.migzdev.dwords/events');

void quizStarted({
  @required QuizType quizType,
  @required Set<String> lessonIds,
  @required bool useTts,
}) =>
    trackEvent('Quiz Started', props: {
      'Type': quizType.toString(),
      'Lesson IDs': lessonIds.toString(),
      'TTS used': useTts.toString(),
    });

void refreshTapped() => trackEvent('Refresh Tapped');

void lessonViewed({@required Lesson lesson}) =>
    trackEvent('Lesson Viewed', props: {
      'ID': lesson.id,
      'Title': lesson.title,
      'Subtitle': lesson.subtitle,
    });

void wordViewed({@required Word word}) => trackEvent('Word Viewed', props: {
      'ID': word.id,
      'word': word.word,
      'pinyin': word.pinyin,
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
