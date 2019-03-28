import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:screen/screen.dart';

import 'package:chinese_words/core/localizations.dart';
import 'package:chinese_words/models/models.dart';
import 'package:chinese_words/core/services.dart';
import 'package:chinese_words/widgets/widgets.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key key,
    this.quizType,
    this.words,
    this.useTts,
  }) : super(key: key);

  final QuizType quizType;
  final List<Word> words;
  final bool useTts;

  @override
  _QuizScreenState createState() => _QuizScreenState(
        provider: QuizService(words: words, quizType: quizType),
        tts: FlutterTts(),
      );
}

class _QuizScreenState extends State<QuizScreen> {
  _QuizScreenState({this.provider, this.tts});

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

    // keep screen awake while we're in this screen
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    // remove wake lock
    Screen.keepOn(false);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // only show the TTS icon if the current item type is pinyin
    // or the answer is already revealed
    final actions = widget.useTts &&
            (provider.currentItemType == QuizItemType.Pinyin || _isRevealed)
        ? [
            IconButton(
              icon: Icon(Icons.volume_up),
              onPressed: _speakCurrentWord,
            ),
          ]
        : null;

    return WillPopScope(
      onWillPop: _willPopScope,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: actions,
          iconTheme: IconThemeData(color: Colors.blueAccent),
        ),
        body: _buildBody(),
      ),
    );
  }

  Future<bool> _willPopScope() {
    final localizations = AppLocalizations.of(context);
    final accentColor = Theme.of(context).accentColor;
    final dialogBtnStyle = TextStyle(color: accentColor);

    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(localizations.quiz.dialogExitTitle),
                content: Text(localizations.quiz.dialogExitContent),
                actions: [
                  FlatButton(
                    child: Text(
                      localizations.app.dialogBtnCancel,
                      style: dialogBtnStyle,
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  FlatButton(
                    child: Text(
                      localizations.quiz.dialogExitBtnDiscard,
                      style: dialogBtnStyle,
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              ),
        ) ??
        false;
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
    // do nothing if useTts is false
    if (!widget.useTts) {
      return;
    }

    // tts should not be played if the current quiz item is chinese
    // and it is not yet revealed
    if (provider.currentItemType == QuizItemType.Hanzi && !_isRevealed) {
      return;
    }

    // only play TTS if we're sure that the language pack for
    // chinese (China) is really available
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
