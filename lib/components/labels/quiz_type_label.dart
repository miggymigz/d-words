import 'package:flutter/material.dart';

import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/models/models.dart';

class QuizTypeLabel extends StatelessWidget {
  const QuizTypeLabel(this.quizType, {this.style});

  final QuizType quizType;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    if (quizType == QuizType.PinyinOnly) {
      return Text(
        localizations.settingValPinyinOnly,
        style: style,
      );
    }

    if (quizType == QuizType.HanziOnly) {
      return Text(
        localizations.settingValHanziOnly,
        style: style,
      );
    }

    if (quizType == QuizType.PinyinHanzi) {
      return Text(
        localizations.settingValHanziPinyin,
        style: style,
      );
    }

    return Text(
      'Unknown QuizType: $quizType',
      style: style,
    );
  }
}
