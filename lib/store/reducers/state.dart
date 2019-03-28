import 'package:json_annotation/json_annotation.dart';

import 'package:chinese_words/models/models.dart';

part 'state.g.dart';

@JsonSerializable()
class AppState {
  final List<Collection> collections;
  final Set<String> selectedLessonIds;
  final Set<String> hiddenLessonIds;
  final QuizType quizType;
  final bool isLoading;
  final bool useTts;
  final bool ttsAvailable;

  AppState({
    this.collections,
    this.selectedLessonIds,
    this.hiddenLessonIds,
    this.quizType,
    this.isLoading,
    this.useTts,
    this.ttsAvailable,
  });

  factory AppState.initial() => AppState(
        collections: List.unmodifiable([]),
        selectedLessonIds: {},
        hiddenLessonIds: {},
        quizType: QuizType.HanziOnly,
        isLoading: true,
        useTts: true,
        ttsAvailable: false,
      );

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  AppState copyWith({
    List<Collection> collections,
    Set<String> selectedLessonIds,
    Set<String> hiddenLessonIds,
    QuizType quizType,
    bool isLoading,
    bool useTts,
    bool ttsAvailable,
  }) =>
      AppState(
        collections: collections ?? this.collections,
        selectedLessonIds: selectedLessonIds ?? this.selectedLessonIds,
        hiddenLessonIds: hiddenLessonIds ?? this.hiddenLessonIds,
        quizType: quizType ?? this.quizType,
        isLoading: isLoading ?? this.isLoading,
        useTts: useTts ?? this.useTts,
        ttsAvailable: ttsAvailable ?? this.ttsAvailable,
      );

  dynamic toJson() => _$AppStateToJson(this);

  static AppState fromPersistedJson(dynamic json) => json == null
      ? AppState.initial()
      : AppState.fromJson(json as Map<String, dynamic>);
}
