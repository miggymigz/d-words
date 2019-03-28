import 'package:flutter/material.dart';

import 'package:chinese_words/core/localizations.dart';

class SettingSelectedLessons extends StatelessWidget {
  const SettingSelectedLessons({
    @required this.selectedLessonIds,
    @required this.onTap,
  });

  final Set<String> selectedLessonIds;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;

    return ListTile(
      title: Text(localizations.settingLblLessons),
      subtitle: _buildSubtitle(context),
      onTap: onTap,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final localizations = AppLocalizations.of(context).quizSettings;
    if (selectedLessonIds.isEmpty) {
      return Text(localizations.settingValNoneSelected,
          style: TextStyle(fontStyle: FontStyle.italic));
    }

    final selectedLessonsCount = selectedLessonIds.length.toString();
    final settingValue = localizations.settingValLessonsSelected
        .replaceFirst('{}', selectedLessonsCount);
    return Text(settingValue);
  }
}
