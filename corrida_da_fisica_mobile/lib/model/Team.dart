

import 'dart:ui';
import 'Player.dart';

class Team{

  String name;
  String image;
  List<Player> players = [];
  late Player teamLeader;
  Image? loadedImage;
  int square = 0;
  bool imageAltered = true;
  bool blocked = false;

  Team(this.name, this.image);

  setTeamLeader(Player leader){
    teamLeader = leader;
  }

  setImageAltered(bool imageAltered ){
    imageAltered = imageAltered;
  }

  blockTeam(){
    blocked = true;
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

  String getImage(){
    return image;
  }

  String getName(){
    return name;
  }
}