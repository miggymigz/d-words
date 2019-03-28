import 'package:flutter/material.dart';

import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/models/models.dart';

import '../labels/quiz_type_label.dart';

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
    return SimpleDialogOption(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: QuizTypeLabel(type, style: TextStyle(fontSize: 16)),
      ),
      onPressed: () => Navigator.pop(context, type),
    );
  }
}
