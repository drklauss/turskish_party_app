class PassEvent {}

class PassLoadEvent extends PassEvent {}

class PassWaitingEvent extends PassEvent {
  int score;
  // List<int> questionNums;

  PassWaitingEvent({required this.score});
}

class PassDoneEvent extends PassEvent {}
