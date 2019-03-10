import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'D Words',
      'pageLessonsTitle': 'D Words',
      'btnStartTest': 'Start Test',
      'lblChooseLessons': 'Choose Lessons',
      'lblUpdatingLessons': 'Updating Lessons...',
    },
    'ko': {
      'title': 'D 낱말',
      'pageLessonsTitle': 'D 낱말',
      'btnStartTest': '퀴즈 시작',
      'lblChooseLessons': '수업 선택',
      'lblUpdatingLessons': '수업 업데이트...',
    },
  };

  String get title => _localizedValues[locale.languageCode]['title'];

  String get pageLessonsTitle =>
      _localizedValues[locale.languageCode]['pageLessonsTitle'];

  String get btnStartTest =>
      _localizedValues[locale.languageCode]['btnStartTest'];

  String get lblChooseLessons =>
      _localizedValues[locale.languageCode]['lblChooseLessons'];

  String get lblUpdatingLessons =>
      _localizedValues[locale.languageCode]['lblUpdatingLessons'];
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
