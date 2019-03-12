import 'package:chinese_words/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class AppState {
  final List<Lesson> lessons;
  final Set<String> selectedLessonIds;
  final QuizType quizType;

  AppState({this.lessons, this.selectedLessonIds, this.quizType});

  factory AppState.initial() => AppState(
        lessons: List.unmodifiable([]),
        selectedLessonIds: {},
        quizType: QuizType.HanziOnly,
      );

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  AppState copyWith(
          {List<Lesson> lessons,
          Set<String> selectedLessonIds,
          QuizType quizType}) =>
      AppState(
        lessons: lessons ?? this.lessons,
        selectedLessonIds: selectedLessonIds ?? this.selectedLessonIds,
        quizType: quizType ?? this.quizType,
      );

  dynamic toJson() => _$AppStateToJson(this);

  static AppState fromPersistedJson(dynamic json) => json == null
      ? AppState.initial()
      : AppState.fromJson(json as Map<String, dynamic>);
}
