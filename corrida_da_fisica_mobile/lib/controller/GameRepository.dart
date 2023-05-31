import 'dart:convert';
import 'dart:developer';

import 'package:corrida_da_fisica_mobile/model/Player.dart';
import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:http/http.dart' as http;


import '../../model/Team.dart';
import '../model/Question.dart';
import '../model/Score.dart';
import '../utils/constants.dart';

enum PageToGo {
  mainMenu,
  warning,
  rollDice,
  waitTurn,
  question,
  waitAnswer,
  answer,
  none
}

class GameRepository extends ChangeNotifier {

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
  late Question question;

  late int year;
  bool themeToggle = false;
  late Stream<dynamic> stream;
  late String tempId;
  late int place;
  List<Score> scores = [];

  connect() {
    SSEClient.subscribeToSSE(
        url: 'http://$backEndUrl/connect',
        header: {
        }).listen((event) {

        var decoded = json.decode(event.data!);
        log(decoded.toString());
        switch (decoded["activity"]) {
          case "winner":
            handleGameEnd(decoded);
            break;
          case "question_end":
            handleQuestionEnd(decoded);
            break;
          case "question":
            handleQuestion(decoded);
            break;
          case "game_lock":
            handleLock(decoded);
            break;
          case "roll":
            handleRoll(decoded);
            break;
          case "roll_result":
            handleRollResult(decoded);
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
  }

  void handleQuestionEnd(decoded){
    var question = decoded["results"]["question"];
    var options = decoded["results"]["options"];
    Map<String, List<Player>> listOptions = {};

    options.keys.forEach((key) {
      listOptions[key] = [];
      for (var player in options[key]) {
        listOptions[key]?.add(teams[currentTeamTurn].getPlayerById(player));
      }
    });
    var answer = decoded["results"]["answer"];
    this.question = Question.withAnswer(question, listOptions, answer);

    nextPage = PageToGo.answer;
  }

  void handleQuestion(decoded){
    var question = decoded["question"];
    var options = decoded["options"];
    Map<String, List<Player>> listOptions = {};

    options.forEach((key) {
      listOptions[key] = [];
    });

    this.question = Question(question, listOptions);

    notifyListeners();

    nextPage = PageToGo.question;
  }

  void handleLock(decoded){
    //if (decoded["locked"] == true){
   //   nextPage = PageToGo.waitTurn;
    //}
  }

  void handleRollResult(decoded){
    nextPage = PageToGo.waitTurn;
  }

  void handleRoll(decoded){
    currentTeamTurn = teams.indexWhere((element) => element.id == decoded["team"]);
    if (decoded["me"] == true && decoded["team"] == player.getTeamID()){
      playersRoll = true;
      nextPage = PageToGo.rollDice;
    }
    else {
      playersRoll = false;
      nextPage = PageToGo.waitTurn;
    }
  }

  void rollDice()async {
    nextPage = PageToGo.none;
    try {
      var body = {
        "code": gameCode,
        "player": player.getID(),
        "team": player.getTeamID()
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/dice/roll"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");

      }
    } catch (e) {
      log(e.toString());
    }
  }

  void sendAnswer() async{
    isLoading = true;
    try {
      var body = {
        "code": gameCode,
        "player": player.getID(),
        "answer": lastAnswer
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/question/answer"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
        nextPage = PageToGo.waitAnswer;
        log(nextPage.toString());
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log("exception");
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  void handleGameEnd(decoded) {
    var positions = decoded["positions"];

    for (var i = 0; i < positions.length(); i++) {
      if (positions[i] == player.getTeamID()) {
        place == i;
      }
    }

    var results = decoded["results"];

    results.forEach((key, value) {
      scores.add(Score(
          positions.indexWhere((element) => element.id == key), key,
          value["moves"], value["correct"],
          value["questions"] - value["correct"]));
      });
  }


  void handleChangeTeam(decoded) {
    if (decoded["id"] != null) {
      player.setId(decoded["id"]);
    }
    teams = [];

    var teamsJson = decoded["teams"];

    Team finalTeam;
    teamsJson.forEach((team) =>
    {
      finalTeam = Team(
          team["name"], "assets/images/team/${team["picture"]}", team["id"]),
      if (team["leader"] != null)
        {
          finalTeam.changeTeamLeader(Player.fromServer(
              team["leader"]["name"],
              team["leader"]["id"],
              "assets/images/profile/${team["leader"]["picture"]}",
              team["leader"]["color"])),
        },
      team["players"].forEach((player) =>
      {
        finalTeam.addPlayer(Player.fromServer(player["name"], player["id"],
            player["picture"], player["color"]))
      }),
      teams.add(finalTeam),
    });
  }

  checkJoin() async {
    isLoading = true;
    try {
      var body = {
        "code": gameCode,
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/game/checkJoin"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
        if (decoded["exists"] == true) {
          themeToggle = decoded["theme"];
          year = decoded["year"];
        }
        nextPage = PageToGo.mainMenu;
        log(nextPage.toString());
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
        nextPage = PageToGo.warning;
      }
    } catch (e) {
      log("exception");
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
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
        if (decoded["teamLeader"] == true) {
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

  void setPlayer(String name, String image) {
    player = Player(name, image);
    playerSet = true;
  }

  String getPfp() {
    return player.image;
  }

  void setTeams() {
    /*
    teams.add(Team("Equipa 1", "assets/images/team/pfp1.png"));
    teams.add(Team("Equipa 2", "assets/images/team/pfp2.png"));
    teams.add(Team("Equipa 3", "assets/images/team/pfp3.png"));
    teams.add(Team("Equipa 4", "assets/images/team/pfp4.png"));
     */
  }

  List<Team> getTeams() {
    return teams;
  }

}