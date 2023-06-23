import 'package:hive_flutter/hive_flutter.dart';

abstract class ScoreRepository {
  int getAccuracy();

  void setAccuracy(int score);

  List<int> getQNums();

  void setQNums(List<int> qNums);
}

class HiveRepository extends ScoreRepository {
  Box box;
  final String _scoreKey = 'score';
  final String _qNumsKey = 'qNums';

  HiveRepository(this.box);

  @override
  int getAccuracy() {
    return box.get(_scoreKey) ?? 0;
  }

  @override
  void setAccuracy(int score) {
    box.put(_scoreKey, score);
  }

  @override
  List<int> getQNums() {
    try {
      return box.get(_qNumsKey) ?? [];
    } catch (_) {
      return [];
    }
  }

  @override
  void setQNums(List<int> qNums) {
    box.put(_qNumsKey, qNums);
  }
}
