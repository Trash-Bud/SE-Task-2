
import 'dart:convert';
import 'dart:developer';

import 'package:corrida_da_fisica_mobile/model/Player.dart';
import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:http/http.dart' as http;


import '../../model/Team.dart';
import '../utils/constants.dart';

enum PageToGo{
  rollDice,
  waitTurn,
  none
}

class GameRepository extends ChangeNotifier{

  String? gameCode;
  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [];
  int currentTeamTurn = 0;
  int numberOfThemes = 0;
  bool isLoading = false;
  bool isPlaying = false;
  bool playerSet = false;
  bool playersRoll = false;
  PageToGo nextPage = PageToGo.none;
  late Player player;
  late int lastAnswer;

  late Stream<dynamic> stream;
  late String tempId;

  connect() {

    SSEClient.subscribeToSSE(
        url: 'http://$backEndUrl/connect',
        header: {
        }).listen((event) {
      log('Data: ' + event.data!);
        var decoded = json.decode(event.data!);
        //log(decoded.toString());
        switch (decoded["activity"]) {
          case "winner":
          //handleQuestionEnd(decoded);
            break;
          case "question_end":
          //handleQuestionEnd(decoded);
            break;
          case "question":
          //handleQuestion(decoded);
            break;
          case "game_lock":
            handleLock(decoded);
            break;
          case "roll":
            handleRoll(decoded);
            break;
          case "roll_result":
          //handleRollResult(decoded);
            break;
          case "change_team":
            handleChangeTeam(decoded);
            break;
          case "connect":
            tempId = decoded["id"];
            joinGame();
            break;
          default:
            log("error");
            break;
        }
        notifyListeners();
    });


    //notifyteam
    //notifyplayer
    //winner
    //changeteam
  }

  void handleLock(decoded){
    if (decoded["locked"] == true){
      nextPage = PageToGo.waitTurn;
    }
  }

  void handleRoll(decoded){
    if (decoded["me"] == true){
      playersRoll = true;
      nextPage = PageToGo.rollDice;

    }
/*
    var currTeam = decoded["team"];
    log(currTeam);
    log(teams[0].toString());
    currentTeamTurn = teams.indexWhere((element) => element.id == currTeam);
    log(currentTeamTurn.toString());
    var currPlayerTurn = decoded["player"];
    log(currPlayerTurn);
    log(teams[currentTeamTurn].players.toString());
    var currentPlayerTurn = teams[currentTeamTurn]
        .players
        .indexWhere((element) => element.id == currPlayerTurn);
    log(currentPlayerTurn.toString());
    isLoading = false;
 */
  }

  void handleChangeTeam(decoded){
    if (decoded["id"] != null){
      player.setId(decoded["id"]);
    }
    teams = [];

    var teamsJson = decoded["teams"];

    Team finalTeam;
    teamsJson.forEach((team) => {
      finalTeam = Team(team["name"], "assets/images/team/${team["picture"]}", team["id"]),
      if (team["leader"] != null)
        {
          finalTeam.changeTeamLeader(Player.fromServer(
              team["leader"]["name"],
              team["leader"]["id"],
              "assets/images/profile/${team["leader"]["picture"]}",
              team["leader"]["color"])),
        },
      team["players"].forEach((player) => {
        finalTeam.addPlayer(Player.fromServer(player["name"], player["id"],
            player["picture"], player["color"]))
      }),
      teams.add(finalTeam),
    });
    log(teams.toString());
  }

  joinTeam() async {
    try {
      var body = {
        "code": gameCode,
        "player": player.getID(),
        "team": player.getTeamID()
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/team/join"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
        if (decoded["teamLeader"] == true){
          player.isLeader = true;
        }
        else {
          player.isLeader = false;
        }
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");

      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  leaveTeam() async {
    try {
      var body = {
        "code": gameCode,
        "playerId": player.getID(),
        "teamsId": player.getTeamID()
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/team/leave"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
        /*
        if (decoded["teamLeader"] == true){
          player.isLeader = true;
        }
        else {
          player.isLeader = false;
          log("lol");
        }
         */
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");

      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }

  joinGame() async {
    isLoading = true;
    try {
      var body = {
        "code": gameCode,
        "name": player.getName(),
        "pic": player.getImage(),
        "color": player.color,
        "id": tempId
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/game/join"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
        //gameCode = decoded["code"].toString();
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }

    isLoading = false;
    notifyListeners();

  }

  void setPlayer(String name, String image){
    player = Player(name, image);
    playerSet = true;
  }

  String getPfp(){
    return player.image;
  }

  void setTeams(){
    /*
    teams.add(Team("Equipa 1", "assets/images/team/pfp1.png"));
    teams.add(Team("Equipa 2", "assets/images/team/pfp2.png"));
    teams.add(Team("Equipa 3", "assets/images/team/pfp3.png"));
    teams.add(Team("Equipa 4", "assets/images/team/pfp4.png"));
     */
  }

  List<Team> getTeams(){
    return teams;
  }

}