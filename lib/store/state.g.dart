// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
      lessons: (json['lessons'] as List)
          ?.map((e) =>
              e == null ? null : Lesson.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      selectedLessonIds:
          (json['selectedLessonIds'] as List)?.map((e) => e as String)?.toSet(),
      quizType: _$enumDecodeNullable(_$QuizTypeEnumMap, json['quizType']));
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'lessons': instance.lessons,
      'selectedLessonIds': instance.selectedLessonIds?.toList(),
      'quizType': _$QuizTypeEnumMap[instance.quizType]
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
