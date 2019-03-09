// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
      id: json['id'] as String,
      word: json['word'] as String,
      pinyin: json['pinyin'] as String,
      definition: json['definition'] as String,
      partOfSpeech: json['partOfSpeech'] as String);
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'pinyin': instance.pinyin,
      'definition': instance.definition,
      'partOfSpeech': instance.partOfSpeech
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return Lesson(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      words: (json['words'] as List)
          .map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'words': instance.words
    };
