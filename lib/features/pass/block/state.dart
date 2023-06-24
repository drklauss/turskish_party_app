class PassState {}

class PassInitial extends PassState {}

class PassQuestionsState extends PassState {
  PassQuestionsState();
}

class PassWaitingState extends PassState {}

class PassDoneState extends PassState {
  int accuracy;
  PassDoneState(this.accuracy);
}
