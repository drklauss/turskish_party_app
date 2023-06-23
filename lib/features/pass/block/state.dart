class PassState {}

class PassInitial extends PassState {}

class PassQuestionsState extends PassState {
  List<int> qNums;

  PassQuestionsState({required this.qNums});
}

class PassWaitingState extends PassState {}

class PassDoneState extends PassState {
  int score;
  PassDoneState(this.score);
}
