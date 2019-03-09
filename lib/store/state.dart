import 'package:chinese_words/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class AppState {
  final List<Lesson> lessons;

  AppState({this.lessons});

  factory AppState.initial() => AppState(lessons: List.unmodifiable([]));

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  AppState copyWith({List<Lesson> lessons, Set<int> selectedLessons}) =>
      AppState(lessons: lessons ?? this.lessons);

  dynamic toJson() => _$AppStateToJson(this);

  static AppState fromPersistedJson(dynamic json) => json == null
      ? AppState.initial()
      : AppState.fromJson(json as Map<String, dynamic>);
}
