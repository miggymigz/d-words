import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/models.dart';
import 'package:chinese_words/store.dart';
import 'package:chinese_words/widgets.dart';
import 'package:chinese_words/localizations.dart';

import 'words_list.dart';
import 'quiz.dart';

class LessonsList extends StatelessWidget {
  static final avatarTextStyle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final appBarTitle = localizations.pageLessonsTitle;
    final updatingLessonsLabel = localizations.lblUpdatingLessons;

    return AppBar(
      title: Text(appBarTitle, style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(updatingLessonsLabel),
                      duration: Duration(seconds: 1),
                    ));

                    StoreProvider.of<AppState>(context)
                        .dispatch(FetchLessonsAction());
                  },
                )),
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
              itemBuilder: (context, i) {
                final lesson = lessons[i];
                final textStyle = avatarTextStyle.copyWith(
                    color: Theme.of(context).primaryColor);

                return ListTile(
                    key: Key(lesson.title),
                    leading: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        child: Text(
                          (i + 1).toString(),
                          style: textStyle,
                        )),
                    title: Text(lesson.title),
                    subtitle: Text(lesson.subtitle),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WordsList(
                                  title: lesson.title, lesson: lesson)));
                    });
              });
        });
  }

  Widget _buildFab(BuildContext context) {
    final fabLabel = AppLocalizations.of(context).btnStartTest;
    return FancyButton(fabLabel, icon: Icons.explore, onTap: () {
      showDialog(context: context, builder: (context) => LessonChooserDialog());
    });
  }
}

class LessonChooserDialog extends StatefulWidget {
  @override
  _LessonChooserDialogState createState() => _LessonChooserDialogState();
}

class _LessonChooserDialogState extends State<LessonChooserDialog> {
  final Set<String> selectedLessonIds = {};

  @override
  Widget build(BuildContext context) {
    final chooseLessonsLabel = AppLocalizations.of(context).lblChooseLessons;
    final startQuizLabel = AppLocalizations.of(context).btnStartTest;

    return AlertDialog(
        title: Text(chooseLessonsLabel),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (context, state) => ListView(
                  children: state.lessons
                      .map((lesson) => CheckboxListTile(
                            title: Text(lesson.title),
                            activeColor: Theme.of(context).accentColor,
                            value: selectedLessonIds.contains(lesson.id),
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue) {
                                  selectedLessonIds.add(lesson.id);
                                } else {
                                  selectedLessonIds.remove(lesson.id);
                                }
                              });
                            },
                          ))
                      .toList())),
        ),
        actions: [
          FlatButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                startQuizLabel,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context, _buildQuizPageRoute());
            },
          )
        ]);
  }

  Route _buildQuizPageRoute() {
    return MaterialPageRoute(builder: (context) {
      final stateSnapshot = StoreProvider.of<AppState>(context).state;

      // make new list from snapshot so as not to unknowlingly modify state
      final lessons = List<Lesson>.from(stateSnapshot.lessons);

      lessons.retainWhere((lesson) => selectedLessonIds.contains(lesson.id));
      final words = lessons.expand((lesson) => lesson.words).toList();

      return WordsQuiz(words: words);
    });
  }
}
