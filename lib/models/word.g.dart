// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

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
