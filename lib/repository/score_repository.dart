import 'package:hive_flutter/hive_flutter.dart';

abstract class ScoreRepository {
  int getScore();

  void setScore(int score);
}

class HiveRepository extends ScoreRepository {
  Box box;
  final String _scoreKey = 'score';

  HiveRepository(this.box);

  @override
  int getScore() {
    return box.get(_scoreKey) ?? 0;
  }

  @override
  void setScore(int score) {
    box.put(_scoreKey, score);
  }
}
