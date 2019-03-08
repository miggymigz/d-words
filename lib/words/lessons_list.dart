import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:chinese_words/models.dart';
import 'package:chinese_words/store.dart';
import 'package:chinese_words/widgets.dart';

import 'words_list.dart';
import 'quiz.dart';

class LessonsList extends StatelessWidget {
  LessonsList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(state.lessons),
          floatingActionButton:
              FancyButton('Start Test', icon: Icons.explore, onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WordsQuiz(
                        words: state.lessons
                            .expand((lesson) => lesson.words)
                            .toList())));
          })),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Center(child: Text(title)),
      elevation: 0,
    );
  }

  Widget _buildBody(List<Lesson> lessons) {
    if (lessons.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, i) {
          final lesson = lessons[i];
          final tileTitle = '第${lesson.order}课';
          final tileSubtitle = lesson.title;

          return ListTile(
            key: Key(lesson.title),
            leading: CircleAvatar(child: Text(lesson.order.toString())),
            title: Text(tileTitle),
            subtitle: Text(tileSubtitle),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WordsList(title: lesson.title, lesson: lesson)));
            },
          );
        });
  }
}
