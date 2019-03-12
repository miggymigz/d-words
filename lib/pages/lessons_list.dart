import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/analytics.dart' as analytics;
import 'package:chinese_words/models.dart';
import 'package:chinese_words/store.dart';
import 'package:chinese_words/widgets.dart';
import 'package:chinese_words/localizations.dart';

import 'words_list.dart';
import 'quiz_settings.dart';

class LessonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final localizations = AppLocalizations.of(context).lessons;
    final accentColor = Theme.of(context).accentColor;

    return AppBar(
      title: Text(
        localizations.title,
        style: TextStyle(fontWeight: FontWeight.bold, color: accentColor),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Builder(
          builder: (context) => IconButton(
                icon: Icon(Icons.refresh, color: Colors.blueAccent),
                onPressed: () {
                  Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(localizations.lblUpdatingLessons),
                      duration: Duration(seconds: 1),
                    ));

                  analytics.refreshTapped();
                  StoreProvider.of<AppState>(context)
                      .dispatch(FetchLessonsAction());
                },
              ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        final lessons = state.lessons;

        if (lessons.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: lessons.length,
          itemBuilder: (context, i) => _buildLessonRow(context, lessons[i], i),
        );
      },
    );
  }

  Widget _buildLessonRow(BuildContext context, Lesson lesson, int index) {
    return ListTile(
      key: Key(lesson.title),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(lesson.title),
      subtitle: Text(lesson.subtitle),
      onTap: () {
        final title = '${lesson.title}：${lesson.subtitle}';

        analytics.lessonViewed(lesson: lesson);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WordsList(title: title, lesson: lesson)));
      },
    );
  }

  Widget _buildFab(BuildContext context) {
    final localizations = AppLocalizations.of(context).lessons;

    return FancyButton(
      localizations.btnStartTest,
      icon: Icons.explore,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => QuizSettings()));
      },
    );
  }
}
