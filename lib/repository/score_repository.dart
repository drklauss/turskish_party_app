abstract class ScoreRepository {
  int getScore();

  void setScore(int score);
}

class HiveRepository extends ScoreRepository {
  @override
  int getScore() {
    return 0;
  }

  @override
  void setScore(int score) {
    // return 0;
  }
}
