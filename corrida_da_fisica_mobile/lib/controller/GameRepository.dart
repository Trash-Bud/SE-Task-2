
import 'dart:developer';

import 'package:corrida_da_fisica_mobile/model/Player.dart';
import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../model/Team.dart';

import '../utils/constants.dart';
import 'sse.dart';

class GameRepository extends ChangeNotifier{

  String? gameCode;
  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [];
  int numberOfThemes = 0;
  bool isLoading = false;
  bool isPlaying = false;
  bool playerSet = false;
  late Player player;
  late int lastAnswer;
  late Stream<dynamic> stream;

  connect(){
    stream = Sse.connect(
      uri: Uri.parse('http://$backEndUrl/connect'),
      closeOnError: true,
      withCredentials: false,
    ).stream;

    log(stream.toString());

    stream.listen((event) {
      log('Received:' + DateTime.now().millisecondsSinceEpoch.toString() + ' : ' + event.toString());
      gameCode = 'Received:' + DateTime.now().millisecondsSinceEpoch.toString() + ' : ' + event.toString();
      notifyListeners();
    }
    );
  }

  joinGame() async {
    try{
      final response = await http.post(Uri.parse('http://$backEndUrl/game/join'),
      body: {
        "code": ""
      });

    }catch (e){
      log(e.toString());
    }
  }

  checkJoin(){

  }

  joinTeam(){

  }

  leaveTeam(){

  }

  rollDice(){

  }

  answerQuestion(){

  }



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