class PassEvent {}

class PassLoadEvent extends PassEvent {}

class PassHandlingEvent extends PassEvent {
  int accuracy;

  PassHandlingEvent({required this.accuracy});
}

class PassDoneEvent extends PassEvent {}
