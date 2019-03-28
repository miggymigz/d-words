import 'package:flutter/material.dart';

import 'package:chinese_words/models/models.dart';

class LessonRow extends StatelessWidget {
  const LessonRow({
    @required this.lesson,
    @required this.order,
    @required this.onTap,
  });

  final Lesson lesson;
  final int order;
  final Function(Lesson) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(lesson.title),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text(
          order.toString(),
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(lesson.title),
      subtitle: Text(lesson.subtitle),
      onTap: () => onTap(lesson),
      // final title = '${lesson.title}：${lesson.subtitle}';

      // analytics.lessonViewed(lesson: lesson);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => WordsList(title: title, lesson: lesson),
      //   ),
      // );
    );
  }
}
