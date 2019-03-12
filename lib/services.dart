import 'dart:math';

import 'package:chinese_words/models.dart';

enum QuizItemType { Hanzi, Pinyin }

class QuizService {
  QuizService({this.words, this.quizType}) {
    if (quizType == QuizType.HanziOnly) {
      _hanziItemIndices = List.generate(words.length, (index) => index);
    } else if (quizType == QuizType.PinyinOnly) {
      _pinyinItemIndices = List.generate(words.length, (index) => index);
    } else {
      _hanziItemIndices = List.generate(words.length, (index) => index);
      _pinyinItemIndices = List.from(_hanziItemIndices);
      _isHanziTurn = true;
    }
  }

  final List<Word> words;
  final QuizType quizType;

  List<int> _hanziItemIndices;
  List<int> _pinyinItemIndices;
  bool _isHanziTurn;
  QuizItemType _currentItemType;

  Word nextWord() => quizType == QuizType.HanziOnly
      ? _nextWordForHanzi()
      : quizType == QuizType.PinyinOnly
          ? _nextWordForPinyin()
          : _nextWordForBoth();

  Word _nextWordForHanzi() => _getRandomWordFrom(list: _hanziItemIndices);

  Word _nextWordForPinyin() => _getRandomWordFrom(list: _pinyinItemIndices);

  Word _nextWordForBoth() {
    if (_isHanziTurn) {
      _currentItemType = QuizItemType.Hanzi;
      _isHanziTurn = false;
      return _getRandomWordFrom(list: _hanziItemIndices);
    }

    _currentItemType = QuizItemType.Pinyin;
    _isHanziTurn = true;
    return _getRandomWordFrom(list: _pinyinItemIndices);
  }

  Word _getRandomWordFrom({List<int> list}) {
    final randomIndex = Random().nextInt(list.length);
    final nextWordIndex = list[randomIndex];
    final nextWord = words[nextWordIndex];

    // remove word index
    list.removeAt(randomIndex);

    return nextWord;
  }

  int get totalItemCount =>
      quizType == QuizType.PinyinHanzi ? words.length * 2 : words.length;

  int get shownItemCount => quizType == QuizType.HanziOnly
      ? words.length - _hanziItemIndices.length
      : quizType == QuizType.PinyinOnly
          ? words.length - _pinyinItemIndices.length
          : (words.length * 2) -
              (_hanziItemIndices.length + _pinyinItemIndices.length);

  double get currentProgress => shownItemCount / totalItemCount;

  QuizItemType get currentItemType => _currentItemType;
}
