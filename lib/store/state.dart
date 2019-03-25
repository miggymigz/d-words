import 'package:chinese_words/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state.g.dart';

@JsonSerializable()
class AppState {
  final List<Collection> collections;
  final Set<String> selectedLessonIds;
  final QuizType quizType;
  final bool useTts;
  final bool ttsAvailable;

  AppState({
    this.collections,
    this.selectedLessonIds,
    this.quizType,
    this.useTts,
    this.ttsAvailable,
  });

  factory AppState.initial() => AppState(
        collections: List.unmodifiable([]),
        selectedLessonIds: {},
        quizType: QuizType.HanziOnly,
        useTts: true,
        ttsAvailable: false,
      );

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  AppState copyWith({
    List<Collection> collections,
    Set<String> selectedLessonIds,
    QuizType quizType,
    bool useTts,
    bool ttsAvailable,
  }) =>
      AppState(
        collections: collections ?? this.collections,
        selectedLessonIds: selectedLessonIds ?? this.selectedLessonIds,
        quizType: quizType ?? this.quizType,
        useTts: useTts ?? this.useTts,
        ttsAvailable: ttsAvailable ?? this.ttsAvailable,
      );

  dynamic toJson() => _$AppStateToJson(this);

  static AppState fromPersistedJson(dynamic json) => json == null
      ? AppState.initial()
      : AppState.fromJson(json as Map<String, dynamic>);
}
