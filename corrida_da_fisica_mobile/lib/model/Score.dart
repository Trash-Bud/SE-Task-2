class Score {

  final int place;
  final int teamId;
  final int moves;
  final int corrects;
  final int wrongs;

  Score(this.place, this.teamId, this.moves, this.corrects, this.wrongs);

  int getPlace() {
    return place;
  }

   int getMoves() {
     return moves;
   }

  int getCorrects() {
    return corrects;
  }

  int getWrongs() {
    return wrongs;
  }
}