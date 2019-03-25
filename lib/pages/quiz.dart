import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  _WordsQuizState createState() => _WordsQuizState(
        provider: QuizService(words: words, quizType: quizType),
        tts: FlutterTts(),
      );
}

class _WordsQuizState extends State<WordsQuiz> {
  _WordsQuizState({this.provider, this.tts});

  final QuizService provider;
  final FlutterTts tts;

  Word _currentWord;
  bool _isRevealed;

  @override
  void initState() {
    super.initState();

    _currentWord = provider.nextWord();
    _isRevealed = false;
    _speakCurrentWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: _speakCurrentWord,
          ),
        ],
      ),
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

      // play tts if available and on first show of card
      if (!_isRevealed) {
        _speakCurrentWord();
      }
    } on RangeError {
      // no words left to quiz
      Navigator.of(context).pop();
    }
  }

  void _speakCurrentWord() async {
    if (await tts.isLanguageAvailable('zh-CN')) {
      await tts.setLanguage('zh-CN');
      await tts.speak(_currentWord.word);
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
      child: Column(
        children: [
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
            ),
          ),
          LinearProgressIndicator(value: provider.currentProgress),
        ],
      ),
    );
  }
}
