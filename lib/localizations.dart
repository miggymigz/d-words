import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const Map<String, LocalizedValues> _localizedValues = {
    'en': LocalizedValues(
      app: AppLocalizedValues(
        title: 'D Words',
        lblFeatureNotAvailable: 'This feature is coming soon!',
        dialogTitleInfo: 'Info',
        dialogBtnOkay: 'OKAY',
      ),
      lessons: LessonLocalizedValues(
        title: 'D Words',
        btnStartTest: 'START TEST',
        lblUpdatingLessons: 'Updating Lessons...',
      ),
      quizSettings: QuizSettingsLocalizedValues(
        title: 'Quiz Settings',
        settingLblQuizType: 'Quiz Type',
        settingLblLessons: 'Lessons',
        settingLblDefinitionLanguages: 'Definition Languages',
        settingValHanziOnly: 'Chinese Characters Only',
        settingValPinyinOnly: 'Pinyin Only',
        settingValHanziPinyin: 'Both Chinese Characters and Pinyin',
        settingValNoneSelected: 'None Selected',
        settingValLanguageEnglish: 'English',
        settingValLanguageKorean: 'Korean',
        btnStartTest: 'START TEST',
        dialogTitleChooseQuizType: 'Choose Quiz Type',
        dialogTitleChooseLessons: 'Choose Lessons',
        dialogTitleEmptySelectedLessons: 'Oops!',
        dialogMessageEmptySelectedLessons:
            'You should select one or more lessons!',
      ),
    ),
    'ko': LocalizedValues(
      app: AppLocalizedValues(
        title: 'D 낱말',
        lblFeatureNotAvailable: '이 기능은 곧 제공 될 예정입니다.',
        dialogTitleInfo: '정보',
        dialogBtnOkay: '승인',
      ),
      lessons: LessonLocalizedValues(
        title: 'D 낱말',
        btnStartTest: '퀴즈 시작',
        lblUpdatingLessons: '수업 업데이트...',
      ),
      quizSettings: QuizSettingsLocalizedValues(
        title: '퀴즈 설정',
        settingLblQuizType: '퀴즈 형식',
        settingLblLessons: '수업',
        settingLblDefinitionLanguages: '정의 언어',
        settingValHanziOnly: '한자 만',
        settingValPinyinOnly: '병음 만',
        settingValHanziPinyin: '병음과 한자 모두',
        settingValNoneSelected: '선택 안함',
        settingValLanguageEnglish: '영어',
        settingValLanguageKorean: '한국어',
        btnStartTest: '퀴즈 시작',
        dialogTitleChooseQuizType: '퀴즈 유형 선택',
        dialogTitleChooseLessons: '수업 선택',
        dialogTitleEmptySelectedLessons: '에러',
        dialogMessageEmptySelectedLessons: '하나 이상의 수업을 선택해야합니다.',
      ),
    ),
  };

  AppLocalizedValues get app => _localizedValues[locale.languageCode].app;

  LessonLocalizedValues get lessons =>
      _localizedValues[locale.languageCode].lessons;

  QuizSettingsLocalizedValues get quizSettings =>
      _localizedValues[locale.languageCode].quizSettings;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  static final supportedLocales = const ['en', 'ko'];

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture<AppLocalizations>(AppLocalizations(locale));

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

class LocalizedValues {
  const LocalizedValues({
    @required this.app,
    @required this.lessons,
    @required this.quizSettings,
  });
  final AppLocalizedValues app;
  final LessonLocalizedValues lessons;
  final QuizSettingsLocalizedValues quizSettings;
}

class AppLocalizedValues {
  const AppLocalizedValues({
    @required this.title,
    @required this.lblFeatureNotAvailable,
    @required this.dialogTitleInfo,
    @required this.dialogBtnOkay,
  });
  final String title;
  final String lblFeatureNotAvailable;
  final String dialogTitleInfo;
  final String dialogBtnOkay;
}

class LessonLocalizedValues {
  const LessonLocalizedValues({
    @required this.title,
    @required this.btnStartTest,
    @required this.lblUpdatingLessons,
  });
  final String title;
  final String btnStartTest;
  final String lblUpdatingLessons;
}

class QuizSettingsLocalizedValues {
  const QuizSettingsLocalizedValues({
    @required this.title,
    @required this.settingLblQuizType,
    @required this.settingLblLessons,
    @required this.settingLblDefinitionLanguages,
    @required this.settingValHanziOnly,
    @required this.settingValPinyinOnly,
    @required this.settingValHanziPinyin,
    @required this.settingValNoneSelected,
    @required this.settingValLanguageEnglish,
    @required this.settingValLanguageKorean,
    @required this.btnStartTest,
    @required this.dialogTitleChooseQuizType,
    @required this.dialogTitleChooseLessons,
    @required this.dialogTitleEmptySelectedLessons,
    @required this.dialogMessageEmptySelectedLessons,
  });
  final String title;
  final String settingLblQuizType;
  final String settingLblLessons;
  final String settingLblDefinitionLanguages;
  final String settingValHanziOnly;
  final String settingValPinyinOnly;
  final String settingValHanziPinyin;
  final String settingValNoneSelected;
  final String settingValLanguageEnglish;
  final String settingValLanguageKorean;
  final String btnStartTest;
  final String dialogTitleChooseQuizType;
  final String dialogTitleChooseLessons;
  final String dialogTitleEmptySelectedLessons;
  final String dialogMessageEmptySelectedLessons;
}
