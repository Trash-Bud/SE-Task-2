

import 'dart:ui';
import 'Player.dart';

class Team{

  final String id;
  String name;
  String image;
  List<Player> players = [];
  Player teamLeader;
  Image? loadedImage;
  int square = 0;

  Team(this.name, this.image, this.teamLeader, this.id){
    players.add(teamLeader);
  }


  // TODO: erase later after all positions in the board are done
  Team.testPos(this.id, this.name, this.image, this.teamLeader, this.square){
    players.add(teamLeader);
  }

  addPlayer(Player player){
    players.add(player);
  }
  
  changeTeamLeader(Player newLeader){
    teamLeader = newLeader;
  }

  changeTeamName(String newName){
    name = newName;
  }

  changeImage(String newImage){
    image = newImage;
  }

  changeSquare(int newSquare){
    square = newSquare;
  }

  setImage(Image image){
    loadedImage = image;
  }

}