import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

enum AppLocalizationToken {
  SettingQuizTypePinyin,
  SettingQuizTypeHanzi,
  SettingQuizTypePinyinHanzi,
  SettingLessonsSelected,
  SettingUseTtsYes,
  SettingUseTtsYesNeedsConfiguration,
  SettingUseTtsNo,
}

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const Map<String, LocalizedValues> _localizedValues = const {
    'en': LocalizedValues(
      app: AppLocalizedValues(
        title: 'D Words',
        lblFeatureNotAvailable: 'This feature is coming soon!',
        lblFeatureAndroidOnly:
            'This feature is only available to Android users.',
        dialogTitleInfo: 'Info',
        dialogBtnOkay: 'OKAY',
        dialogBtnCancel: 'CANCEL',
      ),
      lessons: LessonLocalizedValues(
        title: 'D Words',
        btnStartTest: 'Start Test',
        lblUpdatingLessons: 'Updating Lessons...',
        overflowLblHiddenLessons: 'Hidden Lessons',
      ),
      hiddenLessons: HiddenLessonsLocalizedValues(
        title: 'Hidden Lessons',
        lblNoHiddenLessons: 'No Hidden Lessons',
      ),
      lessonDetails: LessonDetailsLocalizedValues(
        actionTooltipLessonVisible: 'Hide Lesson',
        actionTooltipLessonHidden: 'Show Lesson',
      ),
      quizSettings: QuizSettingsLocalizedValues(
        title: 'Quiz Settings',
        settingLblQuizType: 'Quiz Type',
        settingLblLessons: 'Lessons',
        settingLblUseTts: 'Use Text-to-Speech',
        settingLblDefinitionLanguages: 'Definition Languages',
        settingValHanziOnly: 'Chinese Characters Only',
        settingValPinyinOnly: 'Pinyin Only',
        settingValHanziPinyin: 'Both Chinese Characters and Pinyin',
        settingValNoneSelected: 'None Selected',
        settingValLessonsSelected: '{} lesson(s) selected',
        settingValTtsFullyAvailable: 'Yes',
        settingValTtsNeedsConfiguration: 'Yes (Needs Configuration)',
        settingValDoNotUseTts: 'No',
        settingValLanguageEnglish: 'English',
        settingValLanguageKorean: 'Korean',
        btnStartTest: 'Start Test',
        dialogTitleChooseQuizType: 'Choose Quiz Type',
        dialogTitleChooseLessons: 'Choose Lessons',
        dialogTitleEmptySelectedLessons: 'Oops!',
        dialogMessageEmptySelectedLessons:
            'You should select one or more lessons!',
      ),
      quiz: QuizLocalizedValues(
        dialogExitTitle: 'Discard current progress?',
        dialogExitContent:
            'This will not save your current progress and you will have to start over again.',
        dialogExitBtnDiscard: 'DISCARD',
      ),
    ),
    'ko': LocalizedValues(
      app: AppLocalizedValues(
        title: 'D 낱말',
        lblFeatureNotAvailable: '이 기능은 곧 제공 될 예정입니다.',
        lblFeatureAndroidOnly: '이 기능은 Android 사용자 만 사용할 수 있습니다.',
        dialogTitleInfo: '정보',
        dialogBtnOkay: '승인',
        dialogBtnCancel: '취소',
      ),
      lessons: LessonLocalizedValues(
        title: 'D 낱말',
        btnStartTest: '퀴즈 시작',
        lblUpdatingLessons: '수업 업데이트...',
        overflowLblHiddenLessons: '숨은 교훈',
      ),
      hiddenLessons: HiddenLessonsLocalizedValues(
        title: '숨은 교훈',
        lblNoHiddenLessons: '숨은 수업이 없다',
      ),
      lessonDetails: LessonDetailsLocalizedValues(
        actionTooltipLessonVisible: '숨겨진 교훈',
        actionTooltipLessonHidden: '쇼 교훈',
      ),
      quizSettings: QuizSettingsLocalizedValues(
        title: '퀴즈 설정',
        settingLblQuizType: '퀴즈 형식',
        settingLblLessons: '수업',
        settingLblUseTts: '텍스트 음성 변환을 사용',
        settingLblDefinitionLanguages: '정의 언어',
        settingValHanziOnly: '한자 만',
        settingValPinyinOnly: '병음 만',
        settingValHanziPinyin: '병음과 한자 모두',
        settingValNoneSelected: '선택 안함',
        settingValLessonsSelected: '{} 강의 선택',
        settingValTtsFullyAvailable: 'TTS 사용',
        settingValTtsNeedsConfiguration: 'TTS 사용 (구성 필요)',
        settingValDoNotUseTts: 'TTS를 사용 하지 마십시오.',
        settingValLanguageEnglish: '영어',
        settingValLanguageKorean: '한국어',
        btnStartTest: '퀴즈 시작',
        dialogTitleChooseQuizType: '퀴즈 유형 선택',
        dialogTitleChooseLessons: '수업 선택',
        dialogTitleEmptySelectedLessons: '에러',
        dialogMessageEmptySelectedLessons: '하나 이상의 수업을 선택해야합니다.',
      ),
      quiz: QuizLocalizedValues(
        dialogExitTitle: '진행을 파기 하시겠습니까?',
        dialogExitContent: '그러면 현재 지행 상황을 저장하지 않으므로 다시 시작해야합니다.',
        dialogExitBtnDiscard: '포기',
      ),
    ),
  };

  AppLocalizedValues get app => _localizedValues[locale.languageCode].app;

  LessonLocalizedValues get lessons =>
      _localizedValues[locale.languageCode].lessons;

  HiddenLessonsLocalizedValues get hiddenLessons =>
      _localizedValues[locale.languageCode].hiddenLessons;

  LessonDetailsLocalizedValues get lessonDetails =>
      _localizedValues[locale.languageCode].lessonDetails;

  QuizSettingsLocalizedValues get quizSettings =>
      _localizedValues[locale.languageCode].quizSettings;

  QuizLocalizedValues get quiz => _localizedValues[locale.languageCode].quiz;

  String fromToken(AppLocalizationToken token) {
    switch (token) {
      case AppLocalizationToken.SettingQuizTypePinyin:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValPinyinOnly;
      case AppLocalizationToken.SettingQuizTypeHanzi:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValHanziOnly;
      case AppLocalizationToken.SettingQuizTypePinyinHanzi:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValHanziPinyin;
      case AppLocalizationToken.SettingLessonsSelected:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValLessonsSelected;
      case AppLocalizationToken.SettingUseTtsYes:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValTtsFullyAvailable;
      case AppLocalizationToken.SettingUseTtsYesNeedsConfiguration:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValTtsNeedsConfiguration;
      case AppLocalizationToken.SettingUseTtsNo:
        return _localizedValues[locale.languageCode]
            .quizSettings
            .settingValDoNotUseTts;
      default:
        throw AssertionError('Unknown Token $token');
    }
  }
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
    @required this.hiddenLessons,
    @required this.lessonDetails,
    @required this.quizSettings,
    @required this.quiz,
  });

  final AppLocalizedValues app;
  final LessonLocalizedValues lessons;
  final HiddenLessonsLocalizedValues hiddenLessons;
  final LessonDetailsLocalizedValues lessonDetails;
  final QuizSettingsLocalizedValues quizSettings;
  final QuizLocalizedValues quiz;
}

class AppLocalizedValues {
  const AppLocalizedValues({
    @required this.title,
    @required this.lblFeatureNotAvailable,
    @required this.lblFeatureAndroidOnly,
    @required this.dialogTitleInfo,
    @required this.dialogBtnOkay,
    @required this.dialogBtnCancel,
  });

  final String title;
  final String lblFeatureNotAvailable;
  final String lblFeatureAndroidOnly;
  final String dialogTitleInfo;
  final String dialogBtnOkay;
  final String dialogBtnCancel;
}

class LessonLocalizedValues {
  const LessonLocalizedValues({
    @required this.title,
    @required this.btnStartTest,
    @required this.lblUpdatingLessons,
    @required this.overflowLblHiddenLessons,
  });

  final String title;
  final String btnStartTest;
  final String lblUpdatingLessons;
  final String overflowLblHiddenLessons;
}

class LessonDetailsLocalizedValues {
  const LessonDetailsLocalizedValues({
    @required this.actionTooltipLessonVisible,
    @required this.actionTooltipLessonHidden,
  });

  final String actionTooltipLessonVisible;
  final String actionTooltipLessonHidden;
}

class QuizSettingsLocalizedValues {
  const QuizSettingsLocalizedValues({
    @required this.title,
    @required this.settingLblQuizType,
    @required this.settingLblLessons,
    @required this.settingLblUseTts,
    @required this.settingLblDefinitionLanguages,
    @required this.settingValHanziOnly,
    @required this.settingValPinyinOnly,
    @required this.settingValHanziPinyin,
    @required this.settingValNoneSelected,
    @required this.settingValLessonsSelected,
    @required this.settingValTtsFullyAvailable,
    @required this.settingValTtsNeedsConfiguration,
    @required this.settingValDoNotUseTts,
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
  final String settingLblUseTts;
  final String settingLblDefinitionLanguages;
  final String settingValHanziOnly;
  final String settingValPinyinOnly;
  final String settingValHanziPinyin;
  final String settingValNoneSelected;
  final String settingValLessonsSelected;
  final String settingValTtsFullyAvailable;
  final String settingValTtsNeedsConfiguration;
  final String settingValDoNotUseTts;
  final String settingValLanguageEnglish;
  final String settingValLanguageKorean;
  final String btnStartTest;
  final String dialogTitleChooseQuizType;
  final String dialogTitleChooseLessons;
  final String dialogTitleEmptySelectedLessons;
  final String dialogMessageEmptySelectedLessons;
}

class QuizLocalizedValues {
  const QuizLocalizedValues({
    @required this.dialogExitTitle,
    @required this.dialogExitContent,
    @required this.dialogExitBtnDiscard,
  });

  final String dialogExitTitle;
  final String dialogExitContent;
  final String dialogExitBtnDiscard;
}

class HiddenLessonsLocalizedValues {
  const HiddenLessonsLocalizedValues({
    @required this.title,
    @required this.lblNoHiddenLessons,
  });

  final String title;
  final String lblNoHiddenLessons;
}
