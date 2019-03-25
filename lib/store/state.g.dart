// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
      collections: (json['collections'] as List)
          ?.map((e) =>
              e == null ? null : Collection.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      selectedLessonIds:
          (json['selectedLessonIds'] as List)?.map((e) => e as String)?.toSet(),
      quizType: _$enumDecodeNullable(_$QuizTypeEnumMap, json['quizType']),
      useTts: json['useTts'] as bool,
      ttsAvailable: json['ttsAvailable'] as bool);
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'collections': instance.collections,
      'selectedLessonIds': instance.selectedLessonIds?.toList(),
      'quizType': _$QuizTypeEnumMap[instance.quizType],
      'useTts': instance.useTts,
      'ttsAvailable': instance.ttsAvailable
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$QuizTypeEnumMap = <QuizType, dynamic>{
  QuizType.PinyinOnly: 'PinyinOnly',
  QuizType.HanziOnly: 'HanziOnly',
  QuizType.PinyinHanzi: 'PinyinHanzi'
};
