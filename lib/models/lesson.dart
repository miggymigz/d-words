import 'package:json_annotation/json_annotation.dart';

import 'word.dart';

part 'lesson.g.dart';

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
