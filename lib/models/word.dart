import 'package:json_annotation/json_annotation.dart';

part 'word.g.dart';

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
