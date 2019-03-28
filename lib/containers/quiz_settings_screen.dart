import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:chinese_words/core/analytics.dart' as analytics;
import 'package:chinese_words/core/helpers.dart' as helper;
import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/components/components.dart';
import 'package:chinese_words/models/models.dart';
import 'package:chinese_words/store/store.dart';

import 'quiz_screen.dart';

class QuizSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;
    final accentColor = Theme.of(context).accentColor;

    return AppBar(
      title: Text(
        localizations.title,
        style: TextStyle(
          color: accentColor,
          fontFamily: 'GoogleSans',
          fontWeight: FontWeight.w700,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.blueAccent),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(children: [
            _buildQuizTypeSetting(context),
            _buildLessonsSetting(context),
            _buildSettingUseTts(context),
            _buildDefinitionLanguagesSetting(context),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _buildStartQuizButton(context),
        ),
      ],
    );
  }

  Widget _buildQuizTypeSetting(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ListTile(
      title: Text(localizations.quizSettings.settingLblQuizType),
      subtitle: StoreConnector<AppState, SettingQuizTypeVM>(
        converter: (store) => SettingQuizTypeVM.from(store),
        builder: (context, vm) => QuizTypeLabel(vm.quizType),
      ),
      onTap: () async {
        final selectedQuizType = await showDialog(
          context: context,
          builder: (context) => QuizTypeChooser(),
        );

        if (selectedQuizType != null) {
          final action = ChangeQuizTypeAction(selectedQuizType);
          StoreProvider.of<AppState>(context).dispatch(action);
        }
      },
    );
  }

  Widget _buildLessonsSetting(BuildContext context) {
    return StoreConnector<AppState, SettingLessonsVM>(
        converter: (store) => SettingLessonsVM.from(store),
        builder: (context, vm) {
          return SettingSelectedLessons(
            selectedLessonIds: vm.selectedLessonIds,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StoreConnector<AppState, SettingLessonsVM>(
                    converter: (store) => SettingLessonsVM.from(store),
                    builder: (context, vm) {
                      return LessonChooserDialog(
                        collections: vm.collections,
                        selectedLessonIds: vm.selectedLessonIds,
                        onTap: vm.onSelectionChanged,
                      );
                    },
                  );
                },
              );
            },
          );
        });
  }

  Widget _buildSettingUseTts(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ListTile(
      title: Text(localizations.quizSettings.settingLblUseTts),
      subtitle: StoreConnector<AppState, SettingUseTtsVM>(
        converter: (store) => SettingUseTtsVM.from(store),
        builder: (context, vm) {
          return UseTtsLabel(
            useTts: vm.useTts,
            ttsAvailable: vm.ttsAvailable,
            style: const TextStyle(fontStyle: FontStyle.italic),
          );
        },
      ),
      trailing: Builder(
        builder: (context) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async {
                  // this app, for the most part, supports both platforms
                  // but this one will only work in Android, sorry iOS users :(
                  if (Platform.isAndroid) {
                    final intent = AndroidIntent(
                      action: 'com.android.settings.TTS_SETTINGS',
                    );
                    await intent.launch();
                  } else {
                    Scaffold.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text(localizations.app.lblFeatureAndroidOnly),
                        duration: Duration(seconds: 1),
                      ));
                  }
                },
              ),
              StoreConnector<AppState, bool>(
                converter: (store) => store.state.useTts,
                builder: (context, useTts) => Switch(
                      value: useTts,
                      onChanged: (newValue) =>
                          StoreProvider.of<AppState>(context)
                              .dispatch(ChangeUseTtsAction(value: newValue)),
                    ),
              ),
            ],
          );
        },
      ),
      onTap: () => StoreProvider.of<AppState>(context)
          .dispatch(ChangeUseTtsAction(toggle: true)),
    );
  }

  Widget _buildDefinitionLanguagesSetting(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return ListTile(
      title: Text(localizations.settingLblDefinitionLanguages),
      subtitle: Text(localizations.settingValLanguageEnglish),
      onTap: () => helper.alertInfo(
            context,
            message: AppLocalizations.of(context).app.lblFeatureNotAvailable,
          ),
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

          final words = helper.getSelectedLessonsWords(
            stateSnapshot.collections,
            stateSnapshot.selectedLessonIds,
          );
          final quizType = stateSnapshot.quizType;
          final useTts = stateSnapshot.useTts;

          analytics.quizStarted(
            lessonIds: selectedLessonIds,
            quizType: quizType,
            useTts: useTts,
          );

          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScreen(
                    words: words,
                    quizType: quizType,
                    useTts: useTts,
                  ),
            ),
          );
        },
      ),
    );
  }
}

class SettingUseTtsVM {
  const SettingUseTtsVM({
    @required this.useTts,
    @required this.ttsAvailable,
  });

  final bool useTts;
  final bool ttsAvailable;

  factory SettingUseTtsVM.from(Store<AppState> store) {
    return SettingUseTtsVM(
      useTts: useTtsSelector(store.state),
      ttsAvailable: ttsAvailableSelector(store.state),
    );
  }
}

class SettingQuizTypeVM {
  const SettingQuizTypeVM({@required this.quizType});

  final QuizType quizType;

  factory SettingQuizTypeVM.from(Store<AppState> store) {
    final quizType = quizTypeSelector(store.state);

    return SettingQuizTypeVM(
      quizType: quizType,
    );
  }
}

class SettingLessonsVM {
  const SettingLessonsVM({
    @required this.collections,
    @required this.selectedLessonIds,
    @required this.onSelectionChanged,
  });

  final List<Collection> collections;
  final Set<String> selectedLessonIds;
  final Function(String, bool) onSelectionChanged;

  factory SettingLessonsVM.from(Store<AppState> store) {
    final collections = visibleCollectionsSelector(
      collectionsSelector(store.state),
      hiddenLessonIdsSelector(store.state),
    );
    final selectedLessonIds = selectedLessonIdsSelector(store.state);

    return SettingLessonsVM(
        collections: collections,
        selectedLessonIds: selectedLessonIds,
        onSelectionChanged: (lessonId, selected) {
          store.dispatch(ChangeLessonSelectionAction(lessonId, selected));
        });
  }
}
