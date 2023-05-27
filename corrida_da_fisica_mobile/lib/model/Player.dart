

class Player{

  final String name;
  final String image;
  late final int teamId;
  late bool isLeader;

  Player(this.name, this.image);

  void setTeam(int id, bool leader){
    teamId = id;
    isLeader = leader;
  }

  int getTeamID(){
    return teamId;
  }
}