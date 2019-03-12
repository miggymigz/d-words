import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/helpers.dart';
import 'package:chinese_words/localizations.dart';
import 'package:chinese_words/models.dart';
import 'package:chinese_words/store.dart';
import 'package:chinese_words/widgets.dart';

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
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return ListView(children: [
      ListTile(
        title: Text(localizations.settingLblQuizType),
        subtitle: StoreConnector<AppState, String>(
          converter: (store) => quizTypeToString(context, store.state.quizType),
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

            return Text(state.lessons
                .where((lesson) => state.selectedLessonIds.contains(lesson.id))
                .map((lesson) => lesson.title)
                .toList()
                .join(', '));
          },
        ),
        onTap: () => showDialog<Set<String>>(
            context: context, builder: (context) => LessonChooser()),
      ),
      ListTile(
        title: Text(localizations.settingLblDefinitionLanguages),
        subtitle: Text(localizations.settingValLanguageEnglish),
        onTap: () => alertInfo(
              context,
              message: AppLocalizations.of(context).app.lblFeatureNotAvailable,
            ),
      )
    ]);
  }

  Widget _buildFab(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return FancyButton(
      localizations.btnStartTest,
      icon: Icons.explore,
      onTap: () {
        final stateSnapshot = StoreProvider.of<AppState>(context).state;
        final selectedLessonIds = stateSnapshot.selectedLessonIds;
        if (selectedLessonIds.isEmpty) {
          alertInfo(
            context,
            title: localizations.dialogTitleEmptySelectedLessons,
            message: localizations.dialogMessageEmptySelectedLessons,
          );
          return;
        }

        final lessons = stateSnapshot.lessons;
        final words = lessons
            .where((lesson) => selectedLessonIds.contains(lesson.id))
            .expand((lesson) => lesson.words)
            .toList();
        final quizType = stateSnapshot.quizType;

        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WordsQuiz(
                    words: words,
                    quizType: quizType,
                  )),
        );
      },
    );
  }
}

class QuizTypeChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return SimpleDialog(
      title: Text(localizations.dialogTitleChooseQuizType),
      children: [
        _buildOption(
          context: context,
          label: localizations.settingValPinyinOnly,
          type: QuizType.PinyinOnly,
        ),
        _buildOption(
          context: context,
          label: localizations.settingValHanziOnly,
          type: QuizType.HanziOnly,
        ),
        _buildOption(
          context: context,
          label: localizations.settingValHanziPinyin,
          type: QuizType.PinyinHanzi,
        ),
      ],
    );
  }

  Widget _buildOption({BuildContext context, String label, QuizType type}) {
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

    return AlertDialog(
      title: Text(localizations.dialogTitleChooseLessons),
      content: SingleChildScrollView(
          child: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          final lessons = state.lessons;
          final selectedLessonIds = state.selectedLessonIds;

          return ListBody(
            children: lessons
                .map((lesson) => CheckboxListTile(
                      title: Text(lesson.title),
                      value: selectedLessonIds.contains(lesson.id),
                      onChanged: (newValue) {
                        StoreProvider.of<AppState>(context).dispatch(
                            ChangeLessonSelectionAction(lesson.id, newValue));
                      },
                    ))
                .toList(),
          );
        },
      )),
    );
  }
}
