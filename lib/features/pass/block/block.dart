import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_party_app/repository/score_repository.dart';

import 'events.dart';
import 'state.dart';

class PassBloc extends Bloc<PassEvent, PassState> {
  final ScoreRepository _scoreRepository;

  PassBloc(this._scoreRepository) : super(PassInitial()) {
    on<PassEvent>((event, emit) async {
      if (event is PassLoadEvent) {
        int score = _scoreRepository.getScore();
        if (score > 0) {
          emit(PassDoneState(score));

          return;
        }

        emit(PassQuestionsState());

        return;
      }

      if (event is PassWaitingEvent) {
        _scoreRepository.setScore(event.score);
        emit(PassWaitingState());
      }

      if (event is PassDoneEvent) {
        int score = _scoreRepository.getScore();
        emit(PassDoneState(score));
      }
    });
  }
}
