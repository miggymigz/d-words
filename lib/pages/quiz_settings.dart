import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/analytics.dart' as analytics;
import 'package:chinese_words/helpers.dart' as helper;
import 'package:chinese_words/localizations.dart';
import 'package:chinese_words/models.dart';
import 'package:chinese_words/store.dart';

import 'quiz.dart';

class QuizSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;
    final accentColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.title, style: TextStyle(color: accentColor)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blueAccent),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView(children: [
            ListTile(
              title: Text(localizations.settingLblQuizType),
              subtitle: StoreConnector<AppState, String>(
                converter: (store) =>
                    helper.quizTypeToString(context, store.state.quizType),
                builder: (context, quizType) => Text(quizType),
              ),
              onTap: () => showDialog<QuizType>(
                  context: context, builder: (context) => QuizTypeChooser()),
            ),
            ListTile(
              title: Text(localizations.settingLblLessons),
              subtitle: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  if (state.selectedLessonIds.isEmpty) {
                    return Text(localizations.settingValNoneSelected,
                        style: TextStyle(fontStyle: FontStyle.italic));
                  }

                  final selectedLessonsCount =
                      state.selectedLessonIds.length.toString();
                  final settingValue = localizations.settingValLessonsSelected
                      .replaceFirst('{}', selectedLessonsCount);
                  return Text(settingValue);
                },
              ),
              onTap: () => showDialog<Set<String>>(
                  context: context, builder: (context) => LessonChooser()),
            ),
            ListTile(
              title: Text(localizations.settingLblDefinitionLanguages),
              subtitle: Text(localizations.settingValLanguageEnglish),
              onTap: () => helper.alertInfo(
                    context,
                    message:
                        AppLocalizations.of(context).app.lblFeatureNotAvailable,
                  ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildStartQuizButton(context),
        ),
      ],
    );
  }

  Widget _buildStartQuizButton(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Text(
            localizations.btnStartTest,
            style: TextStyle(
              fontFamily: 'GoogleSans',
              fontSize: 18,
            ),
          ),
        ),
        onPressed: () {
          final stateSnapshot = StoreProvider.of<AppState>(context).state;
          final selectedLessonIds = stateSnapshot.selectedLessonIds;
          if (selectedLessonIds.isEmpty) {
            helper.alertInfo(
              context,
              title: localizations.dialogTitleEmptySelectedLessons,
              message: localizations.dialogMessageEmptySelectedLessons,
            );
            return;
          }

          final words = helper.getSelectedLessonsWords(stateSnapshot);
          final quizType = stateSnapshot.quizType;

          analytics.quizStarted(
              lessonIds: selectedLessonIds, quizType: quizType);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordsQuiz(
                    words: words,
                    quizType: quizType,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class QuizTypeChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return SimpleDialog(
      title: Text(localizations.dialogTitleChooseQuizType),
      children: QuizType.values
          .map((type) => _buildOption(context: context, type: type))
          .toList(),
    );
  }

  Widget _buildOption({BuildContext context, QuizType type}) {
    final label = helper.quizTypeToString(context, type);

    return SimpleDialogOption(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(label, style: TextStyle(fontSize: 16)),
      ),
      onPressed: () {
        StoreProvider.of<AppState>(context)
            .dispatch(ChangeQuizTypeAction(type));
        Navigator.pop(context);
      },
    );
  }
}

class LessonChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          final collections = state.collections;
          final selectedLessonIds = state.selectedLessonIds;
          final items = helper.createListItems(collections);

          return SimpleDialog(
            title: Text(localizations.dialogTitleChooseLessons),
            children: items.map((item) {
              final collectionIndex = item[0];
              final collection = collections[collectionIndex];

              final lessonIndex = item[1];
              final lesson =
                  lessonIndex == null ? null : collection.lessons[lessonIndex];
              final lessonSelected = lesson != null
                  ? selectedLessonIds.contains(lesson.id)
                  : false;
              return _buildRow(context, collection, lesson, lessonSelected);
            }).toList(),
          );
        });
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
            onPressed: () {
              StoreProvider.of<AppState>(context).dispatch(
                  ChangeLessonSelectionAction(lesson.id, !lessonSelected));
            },
          );
  }
}
