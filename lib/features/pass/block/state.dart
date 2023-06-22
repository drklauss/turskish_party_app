class PassState {}

class PassInitial extends PassState {}

class PassQuestionsState extends PassState {}

class PassWaitingState extends PassState {}

class PassDoneState extends PassState {
  int score;
  PassDoneState(this.score);
}
