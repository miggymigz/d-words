import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(nullable: false)
class Word {
  const Word(
      {this.id, this.word, this.pinyin, this.definition, this.partOfSpeech});

  final String id;
  final String word;
  final String pinyin;
  final String definition;
  final String partOfSpeech;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}

@JsonSerializable(nullable: false)
class Lesson {
  const Lesson({this.id, this.title, this.subtitle, this.words});

  final String id;
  final String title;
  final String subtitle;
  final List<Word> words;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}

@JsonSerializable(nullable: false)
class Collection {
  const Collection({this.id, this.name, this.lessons});

  final String id;
  final String name;
  final List<Lesson> lessons;

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

enum QuizType { PinyinOnly, HanziOnly, PinyinHanzi }
