import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turkish_party_app/features/pass/repository/score.dart';
import 'events.dart';
import 'state.dart';

class PassBloc extends Bloc<PassEvent, PassState> {
  final ScoreRepository _scoreRepository;

  PassBloc(this._scoreRepository) : super(PassInitial()) {
    on<PassEvent>((event, emit) async {
      if (event is PassLoadEvent) {
        int score;
        try {
          score = _scoreRepository.getAccuracy();
        } catch (_) {
          score = 0;
        }

        if (score > 0) {
          emit(PassDoneState(score));

          return;
        }

        List<int> qNums;
        try {
          qNums = _scoreRepository.getQNums();
        } catch (_) {
          qNums = [];
        }

        emit(PassQuestionsState(qNums: qNums));

        return;
      }

      if (event is PassHandlingEvent) {
        _scoreRepository.setAccuracy(event.accuracy);
        _scoreRepository.setQNums(event.qNums);
        emit(PassWaitingState());
      }

      if (event is PassDoneEvent) {
        int score = _scoreRepository.getAccuracy();
        emit(PassDoneState(score));
      }
    });
  }
}
