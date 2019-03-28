import 'package:redux/redux.dart';

import 'package:chinese_words/store/actions/actions.dart';
import 'package:chinese_words/models/models.dart';

final quizTypeReducer = combineReducers<QuizType>([
  TypedReducer<QuizType, ChangeQuizTypeAction>(_changeQuizType),
]);

QuizType _changeQuizType(
  QuizType state,
  ChangeQuizTypeAction action,
) =>
    action.quizType;
