import 'package:chinese_words/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class AppState {
  final List<Collection> collections;
  final Set<String> selectedLessonIds;
  final QuizType quizType;

  AppState({
    this.collections,
    this.selectedLessonIds,
    this.quizType,
  });

  factory AppState.initial() => AppState(
        collections: List.unmodifiable([]),
        selectedLessonIds: {},
        quizType: QuizType.HanziOnly,
      );

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  AppState copyWith(
          {List<Collection> collections,
          Set<String> selectedLessonIds,
          QuizType quizType}) =>
      AppState(
        collections: collections ?? this.collections,
        selectedLessonIds: selectedLessonIds ?? this.selectedLessonIds,
        quizType: quizType ?? this.quizType,
      );

  dynamic toJson() => _$AppStateToJson(this);

  static AppState fromPersistedJson(dynamic json) => json == null
      ? AppState.initial()
      : AppState.fromJson(json as Map<String, dynamic>);
}
