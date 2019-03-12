import 'package:flutter/material.dart';

import 'package:chinese_words/models.dart';
import 'package:chinese_words/services.dart';
import 'package:chinese_words/widgets.dart';

class WordsQuiz extends StatefulWidget {
  const WordsQuiz({
    Key key,
    this.quizType,
    this.words,
  }) : super(key: key);

  final QuizType quizType;
  final List<Word> words;

  @override
  _WordsQuizState createState() =>
      _WordsQuizState(provider: QuizService(words: words, quizType: quizType));
}

class _WordsQuizState extends State<WordsQuiz> {
  _WordsQuizState({this.provider});

  final QuizService provider;

  Word _currentWord;
  bool _isRevealed;

  @override
  void initState() {
    super.initState();

    _currentWord = provider.nextWord();
    _isRevealed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: _buildBody(),
    );
  }

  void _onWordTapped() {
    try {
      setState(() {
        if (_isRevealed) {
          _currentWord = provider.nextWord();
          _isRevealed = false;
        } else {
          _isRevealed = true;
        }
      });
    } on RangeError {
      Navigator.of(context).pop();
    }
  }

  bool get shouldShowWord {
    if (provider.quizType == QuizType.HanziOnly) {
      return true;
    } else if (provider.quizType == QuizType.PinyinOnly) {
      return _isRevealed;
    } else {
      if (provider.currentItemType == QuizItemType.Hanzi) {
        return true;
      } else {
        return _isRevealed;
      }
    }
  }

  bool get shouldShowPinyin {
    if (provider.quizType == QuizType.HanziOnly) {
      return _isRevealed;
    } else if (provider.quizType == QuizType.PinyinOnly) {
      return true;
    } else {
      if (provider.currentItemType == QuizItemType.Hanzi) {
        return _isRevealed;
      } else {
        return true;
      }
    }
  }

  Widget _buildBody() {
    return GestureDetector(
        onTap: _onWordTapped,
        child: Column(children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(32),
            child: WordDetails(
              _currentWord,
              showWord: shouldShowWord,
              showPinyin: shouldShowPinyin,
              showPartOfSpeech: true,
              showDefinition: _isRevealed,
            ),
          )),
          LinearProgressIndicator(value: provider.currentProgress),
        ]));
  }
}
