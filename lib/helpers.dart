import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'localizations.dart';
import 'models.dart';
import 'store.dart';

/// Convenience method for quickly showing alert dialogs
/// that simply contains a title, a message, and an ok button.
void alert(
  BuildContext context, {
  @required String title,
  @required String message,
  String okLabel,
}) {
  if (okLabel == null) {
    okLabel = AppLocalizations.of(context).app.dialogBtnOkay;
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                okLabel,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
  );
}

/// Javascript-style function to quickly show alert info
void alertInfo(
  BuildContext context, {
  String title,
  @required String message,
  String okLabel,
}) {
  final localizations = AppLocalizations.of(context).app;
  alert(
    context,
    title: localizations.dialogTitleInfo,
    message: message,
  );
}

/// Converts the given QuizType to a localized string
String quizTypeToString(BuildContext context, QuizType quizType) {
  final localizations = AppLocalizations.of(context).quizSettings;

  if (quizType == QuizType.HanziOnly) {
    return localizations.settingValHanziOnly;
  }

  if (quizType == QuizType.PinyinOnly) {
    return localizations.settingValPinyinOnly;
  }

  if (quizType == QuizType.PinyinHanzi) {
    return localizations.settingValHanziPinyin;
  }

  throw AssertionError('Unknown quizType="$quizType"');
}

/// Creates a small description of the TTS setting value
///  based on the given flags
String stringifyTtsState(bool useTts, bool ttsAvailable) {
  print('useTts: $useTts, ttsAvailable: $ttsAvailable');

  if (useTts && ttsAvailable) {
    return 'Yes';
  }

  if (useTts && !ttsAvailable) {
    return 'Yes (TTS needs configuration)';
  }

  return 'No';
}

/// Combines all the lessons in each of the given collections.
///
/// The resulting list contains a pair of the collection index and the lesson index.
/// Header items will have its lesson index as null.
List<List<int>> createListItems(
  List<Collection> collections, {
  bool includeCollection(Collection collection),
  bool includeLesson(Lesson lesson),
}) {
  final items = List<List<int>>();

  collectionLoop:
  for (var i = 0; i < collections.length; i++) {
    final collection = collections[i];

    if (includeCollection != null && !includeCollection(collection)) {
      continue collectionLoop;
    }

    // will represent header row
    items.add([i, null]);

    // collect all lessons in current collection
    lessonLoop:
    for (var j = 0; j < collection.lessons.length; j++) {
      final lesson = collection.lessons[j];

      if (includeLesson != null && !includeLesson(lesson)) {
        continue lessonLoop;
      }

      items.add([i, j]);
    }
  }

  return List.unmodifiable(items);
}

/// Combines all the words of all the selected lessons in the store
List<Word> getSelectedLessonsWords(AppState state) {
  final collections = state.collections;
  final selectedLessonIds = state.selectedLessonIds;
  final selectedWords = [];

  for (var i = 0; i < collections.length; i++) {
    final lessons = collections[i].lessons;

    for (var j = 0; j < lessons.length; j++) {
      final lesson = lessons[j];

      if (selectedLessonIds.contains(lesson.id)) {
        selectedWords.addAll(lesson.words);
      }
    }
  }

  return List<Word>.unmodifiable(selectedWords);
}
