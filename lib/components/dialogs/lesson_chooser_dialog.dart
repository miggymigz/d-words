import 'package:flutter/material.dart';

import 'package:chinese_words/core/helpers.dart' as helper;
import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/models/models.dart';

class LessonChooserDialog extends StatelessWidget {
  const LessonChooserDialog({
    @required this.collections,
    @required this.selectedLessonIds,
    @required this.onTap,
  });

  final List<Collection> collections;
  final Set<String> selectedLessonIds;
  final Function(String, bool) onTap;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;
    final items = helper.createListItems(collections);

    return SimpleDialog(
      title: Text(localizations.dialogTitleChooseLessons),
      children: items.map((item) {
        final collectionIndex = item[0];
        final collection = collections[collectionIndex];

        final lessonIndex = item[1];
        final lesson =
            lessonIndex == null ? null : collection.lessons[lessonIndex];
        final lessonSelected =
            lesson != null ? selectedLessonIds.contains(lesson.id) : false;
        return _buildRow(context, collection, lesson, lessonSelected);
      }).toList(),
    );
  }

  Widget _buildRow(BuildContext context, Collection collection, Lesson lesson,
      bool lessonSelected) {
    // create header item if lesson is null
    return lesson == null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              collection.name,
              style: TextStyle(color: Colors.white70),
            ),
          )
        : SimpleDialogOption(
            child: Row(
              children: <Widget>[
                Opacity(
                  opacity: lessonSelected ? 1 : 0,
                  child: Icon(Icons.check, color: Colors.blueAccent),
                ),
                SizedBox(width: 8),
                Text(lesson.title),
              ],
            ),
            onPressed: () => onTap(lesson.id, !lessonSelected),
          );
  }
}
