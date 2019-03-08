import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(nullable: false)
class Word {
  Word({this.word, this.pinyin, this.definition, this.partOfSpeech});

  final String word;
  final String pinyin;
  final String definition;
  final String partOfSpeech;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}

@JsonSerializable(nullable: false)
class Lesson {
  Lesson({this.order, this.title, this.words});

  final int order;
  final String title;
  final List<Word> words;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
