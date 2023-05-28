
import 'package:corrida_da_fisica_mobile/model/Player.dart';
import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:flutter/cupertino.dart';

import '../../model/Team.dart';

class GameRepository extends ChangeNotifier{

  String? gameCode;
  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [];
  int numberOfThemes = 0;
  bool isLoading = false;
  bool isPlaying = false;
  bool playerSet = false;
  late Player player;

  void setPlayer(String name, int image){
    player = Player(name, image);
    playerSet = true;
  }

  int getPfp(){
    return player.image;
  }

  void setTeams(){
    teams.add(Team("Equipa 1", "assets/images/team/pfp1.png"));
    teams.add(Team("Equipa 2", "assets/images/team/pfp2.png"));
    teams.add(Team("Equipa 3", "assets/images/team/pfp3.png"));
    teams.add(Team("Equipa 4", "assets/images/team/pfp4.png"));
  }

  List<Team> getTeams(){
    return teams;
  }

}