class PassEvent {}

class PassLoadEvent extends PassEvent {}

class PassHandlingEvent extends PassEvent {
  int accuracy;
  List<int> qNums;

  PassHandlingEvent({required this.accuracy, required this.qNums});
}

class PassDoneEvent extends PassEvent {}
