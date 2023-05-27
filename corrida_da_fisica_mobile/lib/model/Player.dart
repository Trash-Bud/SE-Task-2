

import 'package:flutter/cupertino.dart';

class Player{

  final String name;
  final int image;
  late int color;
  late final int teamId;
  late bool isLeader;
  late final Widget coloredImage;

  Player(this.name, this.image);

  void setTeam(int id, bool leader){
    teamId = id;
    isLeader = leader;
  }

  int getTeamID(){
    return teamId;
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

  int getImage(){
    return image;
  }

  Widget getPfp(){
    return coloredImage;
  }
}