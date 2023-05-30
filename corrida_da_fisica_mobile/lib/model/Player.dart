

import 'package:flutter/cupertino.dart';

class Player{
  late final String id;
  String name;
  String image;
  late int color;
  late String teamId;
  late bool isLeader;
  late Widget coloredImage;

  Player(this.name, this.image);
  Player.fromServer(this.name, this.id, this.image, this.color);

  void setTeam(String id){
    teamId = id;
  }

  void setId(String newId){
    id = newId;
  }

  String getID(){
    return id;
  }

  String getTeamID(){
    return teamId;
  }

  String getName(){
    return name;
  }

  void setColor(int colorID){
    color = colorID;
  }

  void setColoredImage(Widget colored){
    coloredImage = colored;
  }

  int getColor(){
    return color;
  }

  String getImage(){
    return image;
  }

  Widget getPfp(){
    return coloredImage;
  }
}