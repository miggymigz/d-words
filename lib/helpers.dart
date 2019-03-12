import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'localizations.dart';
import 'models.dart';

void alert(
  BuildContext context, {
  @required String title,
  @required String message,
  String okLabel,
}) {
  if (okLabel == null) {
    okLabel = AppLocalizations.of(context).app.dialogBtnOkay;
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                okLabel,
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
  );
}

void alertInfo(
  BuildContext context, {
  String title,
  @required String message,
  String okLabel,
}) {
  final localizations = AppLocalizations.of(context).app;
  alert(
    context,
    title: localizations.dialogTitleInfo,
    message: message,
  );
}

String quizTypeToString(BuildContext context, QuizType quizType) {
  final localizations = AppLocalizations.of(context).quizSettings;

  if (quizType == QuizType.HanziOnly) {
    return localizations.settingValHanziOnly;
  }

  if (quizType == QuizType.PinyinOnly) {
    return localizations.settingValPinyinOnly;
  }

  if (quizType == QuizType.PinyinHanzi) {
    return localizations.settingValHanziPinyin;
  }

  throw AssertionError('Unknown quizType="$quizType"');
}
