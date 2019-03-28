import 'package:flutter/material.dart';

import 'package:chinese_words/core/analytics.dart' as analytics;
import 'package:chinese_words/core/helpers.dart' as helper;
import 'package:chinese_words/models/models.dart';
import 'package:chinese_words/widgets/widgets.dart';

import 'words_list.dart';

class LessonList extends StatelessWidget {
  const LessonList({
    @required this.collections,
    @required this.isLoading,
    this.emptyIcon,
    this.emptyLabel,
  });

  final List<Collection> collections;
  final bool isLoading;
  final IconData emptyIcon;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    if (collections.isEmpty) {
      if (isLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        return _buildEmptyIndicator();
      }
    }

    final items = helper.createListItems(collections);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        final collectionIndex = items[i][0];
        final collection = collections[collectionIndex];

        // header row
        if (items[i][1] == null) {
          return CollectionHeader(collection: collection);
        }

        final lessonIndex = items[i][1];
        final lesson = collection.lessons[lessonIndex];

        return LessonRow(
          lesson: lesson,
          order: lessonIndex + 1,
          onTap: _lessonTapped(context),
        );
      },
    );
  }

  Widget _buildEmptyIndicator() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            emptyIcon ?? Icons.book,
            size: 64,
            color: Colors.white30,
          ),
          SizedBox(height: 24),
          Text(
            emptyLabel ?? 'No Lessons Available',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 24,
              fontFamily: 'GoogleSans',
            ),
          ),
        ],
      ),
    );
  }

  Function(Lesson) _lessonTapped(BuildContext context) {
    return (lesson) {
      final title = '${lesson.title}：${lesson.subtitle}';

      analytics.lessonViewed(lesson: lesson);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WordsList(title: title, lesson: lesson),
        ),
      );
    };
  }
}
