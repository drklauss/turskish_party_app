class PassEvent {}

class PassLoadEvent extends PassEvent {}

class PassWaitingEvent extends PassEvent {
  int score;

  PassWaitingEvent({required this.score});
}

class PassDoneEvent extends PassEvent {}
