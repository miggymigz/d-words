import 'package:flutter/material.dart';

import 'package:chinese_words/core/localizations.dart';

class UseTtsLabel extends StatelessWidget {
  const UseTtsLabel({
    @required this.useTts,
    @required this.ttsAvailable,
    this.style,
  });

  final bool useTts;
  final bool ttsAvailable;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    if (useTts && ttsAvailable) {
      return Text(
        localizations.settingValTtsFullyAvailable,
        style: style,
      );
    }

    if (useTts && !ttsAvailable) {
      return Text(
        localizations.settingValTtsNeedsConfiguration,
        style: style,
      );
    }

    return Text(
      localizations.settingValDoNotUseTts,
      style: style,
    );
  }
}
