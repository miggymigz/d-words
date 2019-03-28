import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:chinese_words/core/analytics.dart' as analytics;
import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/models/models.dart';
import 'package:chinese_words/store/store.dart';

import 'word_details.dart';

class WordsList extends StatelessWidget {
  const WordsList({Key key, this.title, this.lesson}) : super(key: key);

  final String title;
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: accentColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        actions: [
          _buildToggleLessonVisibilityAction(context),
        ],
      ),
      body: ListView.builder(
        itemCount: lesson.words.length,
        itemBuilder: _buildRow,
      ),
    );
  }

  Widget _buildToggleLessonVisibilityAction(BuildContext context) {
    final localizations = AppLocalizations.of(context).lessonDetails;

    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.hiddenLessonIds.contains(lesson.id),
      builder: (context, isVisible) => IconButton(
            icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
            onPressed: () => StoreProvider.of<AppState>(context)
                .dispatch(ToggleLessonVisibilityAction(lesson.id)),
            tooltip: isVisible
                ? localizations.actionTooltipLessonHidden
                : localizations.actionTooltipLessonVisible,
          ),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    final word = lesson.words[index];
    final title = word.word + ' ' + word.pinyin;

    return ListTile(
      key: Key(word.word),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      title: Text(title),
      subtitle: MarkdownBody(
        data: word.definition,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
            .copyWith(p: TextStyle(color: Colors.white70)),
      ),
      trailing: Text(word.partOfSpeech),
      onTap: () {
        analytics.wordViewed(word: word);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordDetails(word: word),
          ),
        );
      },
    );
  }
}
