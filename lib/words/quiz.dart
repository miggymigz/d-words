import 'dart:math';

import 'package:flutter/material.dart';

import 'package:chinese_words/models.dart';

class WordsQuiz extends StatefulWidget {
  const WordsQuiz({
    Key key,
    this.words,
  }) : super(key: key);

  final List<Word> words;

  @override
  _WordsQuizState createState() => _WordsQuizState();
}

class _WordsQuizState extends State<WordsQuiz> {
  List<int> _indices = [];
  Word _currentWord;
  int _currentIndex;
  bool _revealed;

  @override
  void initState() {
    super.initState();

    final wordsLength = widget.words.length;
    _indices = List.generate(wordsLength, (index) => index);
    _currentIndex = _getNextWordIndex();
    _indices.remove(_currentIndex);
    _currentWord = widget.words[_currentIndex];
    _revealed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: GestureDetector(
        onTap: _onWordTapped,
        child: Column(
          children: <Widget>[
            Expanded(child: _buildCurrentWord()),
            LinearProgressIndicator(value: _calculateProgress()),
          ],
        ),
      ),
    );
  }

  int _getNextWordIndex() {
    // get a random index from the index list
    final index = Random().nextInt(_indices.length);

    // return the actual index contained in the index
    return _indices[index];
  }

  void _onWordTapped() {
    if (!_revealed) {
      setState(() {
        _revealed = true;
      });
    } else {
      try {
        final nextWordIndex = _getNextWordIndex();

        setState(() {
          _indices.remove(nextWordIndex);
          _currentIndex = nextWordIndex;
          _currentWord = widget.words[_currentIndex];
          _revealed = false;
        });
      } catch (err) {
        Navigator.of(context).pop();
      }
    }
  }

  double _calculateProgress() {
    final wordsLength = widget.words.length;
    return (wordsLength - _indices.length) / wordsLength;
  }

  Widget _buildCurrentWord() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_currentWord.word, style: TextStyle(fontSize: 86)),
          Opacity(
            opacity: _revealed ? 1 : 0,
            child: Text(_currentWord.pinyin, style: TextStyle(fontSize: 24)),
          ),
          Text(
            _currentWord.partOfSpeech + '词',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 15),
          Opacity(
            opacity: _revealed ? 1 : 0,
            child: Text(_currentWord.definition),
          ),
        ],
      ),
    );
  }
}
