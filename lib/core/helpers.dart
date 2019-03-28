import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:chinese_words/models/models.dart';

import 'localizations.dart';

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

/// Combines all the lessons in each of the given collections.
///
/// The resulting list contains a pair of the collection index and the lesson index.
/// Header items will have its lesson index as null.
List<List<int>> createListItems(List<Collection> collections) {
  final items = List<List<int>>();

  for (var i = 0; i < collections.length; i++) {
    final collection = collections[i];

    // will represent header row
    items.add([i, null]);

    // collect all lessons in current collection
    for (var j = 0; j < collection.lessons.length; j++) {
      items.add([i, j]);
    }
  }

  return List.unmodifiable(items);
}

/// Combines all the words of all the selected lessons in the store
List<Word> getSelectedLessonsWords(
  List<Collection> collections,
  Set<String> selectedLessonIds,
) {
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
