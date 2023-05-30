import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:corrida_da_fisica_web/model/Board.dart';
import 'package:corrida_da_fisica_web/model/Player.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/Question.dart';
import '../../model/Team.dart';
import '../../model/game_state.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../see.dart';

class GameRepository extends ChangeNotifier {
  String gameCode = "";
  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [];
  int numberOfTeams = 0;
  int maxPlayerNumber = 2;
  Board board = Board();
  GameState gameState = GameState.waitingDice;
  bool extraQuestion = false;
  List<Player> pendingPlayers = [];
  bool isLoading = false;
  bool boardIsLoading = false;
  int rolledNumber = 1;
  int currentTeamTurn = 0;
  int currentPlayerTurn = 0;
  int year = 7;
  bool applyTheme = false;
  late Question question;
  late bool questionWon;
  late Sse stream;
  late String tempId;
  late Timer timer;
  int seconds = 30;
  List<int> totalPlayerNum = [];
  late Team winner;
  bool won = false;

  connect() {
    stream = Sse.connect(
      uri: Uri.parse('http://$backEndUrl/connect'),
      closeOnError: true,
      withCredentials: false,
    );

    stream.stream.listen((event) {
      var decoded = json.decode(event);
      log(decoded.toString());
      switch (decoded["activity"]) {
        case "question_end":
          handleQuestionEnd(decoded);
          break;
        case "question":
          handleQuestion(decoded);
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
          createGame();
          break;
        default:
          log("error");
          break;
      }
      notifyListeners();
    });
  }

  void handleChangeTeam(decoded) {
    totalPlayerNum = [];
    pendingPlayers = [];
    teams = [];

    var pendingP = decoded["pendingPlayers"];

    pendingP.forEach((player) => {
          log(pendingP.toString()),
          pendingPlayers.add(Player(
              player["name"], player["id"], player["picture"], player["color"]))
        });

    var teamsJson = decoded["teams"];

    Team finalTeam;
    var counter = 0;
    teamsJson.forEach((team) => {
          totalPlayerNum.add(0),
          finalTeam = Team(team["name"], team["picture"], team["id"]),
          if (team["leader"] != null)
            {
              finalTeam.changeTeamLeader(Player(
                  team["leader"]["name"],
                  team["leader"]["id"],
                  team["leader"]["picture"],
                  team["leader"]["color"])),
            },
          team["players"].forEach((player) => {
                totalPlayerNum[counter] += 1,
                finalTeam.addPlayer(Player(player["name"], player["id"],
                    player["picture"], player["color"]))
              }),
          teams.add(finalTeam),
          counter ++
        });
  }

  void handleRollResult(decoded) {
    gameState = GameState.rolledDice;
    rolledNumber = decoded["result"];
  }

  void handleRoll(decoded) {
    gameState = GameState.waitingDice;

    var currTeam = decoded["team"];
    log(currTeam);
    log(teams[0].toString());
    currentTeamTurn = teams.indexWhere((element) => element.id == currTeam);
    log(currentTeamTurn.toString());
    var currPlayerTurn = decoded["player"];
    log(currPlayerTurn);
    log(teams[currentTeamTurn].players.toString());
    currentPlayerTurn = teams[currentTeamTurn]
        .players
        .indexWhere((element) => element.id == currPlayerTurn);
    log(currentPlayerTurn.toString());
    isLoading = false;
  }

  void handleQuestion(decoded) {
    gameState = GameState.question;

    var question = decoded["question"];
    var options = decoded["options"];
    Map<String, List<Player>> listOptions = {};
    options.keys.forEach((key) {
      listOptions[key] = [];
    });

    this.question = Question(question, listOptions);
    log(question.toString());

    notifyListeners();
    isLoading = false;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        notifyListeners();
      } else {
        timer.cancel();
        seconds = 30;
        sendTimeOut();
      }
    });
  }

  changeCurrentTeam(){
    currentTeamTurn = (currentTeamTurn +1) % numberOfTeams;
  }

  void handleQuestionEnd(decoded) {
    gameState = GameState.questionEnd;

    if (decoded["result"] == "won") {
      questionWon = true;
    } else {
      questionWon = false;
    }

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

    if (decoded["newQuestion"]) {
      extraQuestion = true;
    }

    if(!extraQuestion && questionWon){
      teams[currentTeamTurn].square += rolledNumber;
      if (teams[currentTeamTurn].square >= 69){
        teams[currentTeamTurn].square = 69;
        won = true;
        sendWinner();
      }
    }

  }


  createGame() async {
    isLoading = true;
    try {
      var body = {
        "theme": applyTheme,
        "year": year,
        "teamNumber": numberOfTeams,
        "playersPerTeam": maxPlayerNumber,
        "id": tempId
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/game/create"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        log(response.body);
        var decoded = json.decode(response.body);
        gameCode = decoded["code"].toString();
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  lockGame() async {
    isLoading = true;
    try {
      var body = {
        "code": gameCode,
      };

      final response = await http.post(
          Uri.parse("http://$backEndUrl/game/lock"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  checkIfAllTeamsHavePeople(){
    return (totalPlayerNum.firstWhere((element) => element == 0, orElse: () => -1) == -1) && totalPlayerNum.isNotEmpty;
  }

  endGame() async {
    if (gameCode != ""){
      isLoading = true;

      var body = {"code": gameCode};

      gameCode = "";
      totalPlayerNum = [];
      pendingPlayers = [];
      teams = [];
      stream.close();

      log(body.toString());

      try {
        final response = await http.post(Uri.parse("http://$backEndUrl/game/end"),
            body: json.encode(body),
            headers: {
              "Content-Type": "application/json",
            });
        if (response.statusCode >= 200 && response.statusCode < 300) {
        } else {
          log("${response.statusCode.toString()}: ${response.body.toString()}");
        }
      } catch (e) {
        log(e.toString());
      }

      isLoading = false;
      notifyListeners();
    }
  }

  chooseRoll() async {
    isLoading = true;

    var body = {"code": gameCode, "team": teams[currentTeamTurn].id};

    try {
      final response = await http.post(
          Uri.parse("http://$backEndUrl/dice/chooseRoll"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  getCard() async {
    isLoading = true;
    var body = {"code": gameCode, "team": teams[currentTeamTurn].id};

    try {
      final response = await http.post(
          Uri.parse("http://$backEndUrl/question/get"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    notifyListeners();
  }

  sendTimeOut() async {
    isLoading = true;
    gameState = GameState.questionEnd;

    String special = "";

    if (board.checkIfTileIsTwoQuestionsTile(teams[currentTeamTurn].square)) {
      special = "doubleQuestion";
    }
    if (board.checkIfTileChangeQuestionTile(teams[currentTeamTurn].square)) {
      special = "replace";
    }
    if (board.checkIfTileTwoChancesTile(teams[currentTeamTurn].square)) {
      special = "doubleChance";
    }

    var body = {"code": gameCode, "special": special};

    try {
      final response = await http.post(
          Uri.parse("http://$backEndUrl/question/timeOut"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  sendWinner() async {
    isLoading = true;
    gameState = GameState.gameEnd;

    var positions = [];
    var teamsCopy = teams;
    teamsCopy.sort((a, b) => a.square.compareTo(b.square));
    teamsCopy = teamsCopy.reversed.toList();
    positions = teamsCopy.map((e) => e.id).toList();
    winner = teamsCopy[0];

    var body = {"code": gameCode, "positions": positions};

    try {
      final response = await http.post(
          Uri.parse("http://$backEndUrl/game/winner"),
          body: json.encode(body),
          headers: {
            "Content-Type": "application/json",
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
      } else {
        log("${response.statusCode.toString()}: ${response.body.toString()}");
      }
    } catch (e) {
      log(e.toString());
    }

    isLoading = false;
  }

  changeTheme(ThemeData theme) {
    board.switchTheme(theme);
  }

  getDiceRollingPlayer() {
    return teams[currentTeamTurn].players[currentPlayerTurn];
  }

  Team getPlayingTeam() {
    return teams[currentTeamTurn];
  }

  loadImages() async {
    boardIsLoading = true;
    await loadBoardImage();
    await loadTeamImages();
    boardIsLoading = false;
    notifyListeners();
  }

  loadBoardImage() async {
    boardIsLoading = true;
    if (board.loadedImage == null || board.imageAltered) {
      var boardImage = await loadImage(board.boardImage);

      if (boardImage != null) {
        board.setImage(boardImage);
        board.setImageAltered(false);
      } else {
        throw Exception("Board image could not be loaded");
      }
    }
    boardIsLoading = false;
    notifyListeners();
  }

  loadTeamImages() async {
    boardIsLoading = true;
    for (var element in teams) {
      if (element.loadedImage == null || element.imageAltered) {
        var image =
            await loadImage("assets/images/icons_teams/${element.image}");
        if (image != null) {
          element.setImage(image);
          element.setImageAltered(false);
        } else {
          throw Exception(
              "Team image for team ${element.id} could not be loaded");
        }
      }
    }
    boardIsLoading = false;
    notifyListeners();
  }

}
