import 'package:corrida_da_fisica_web/model/Board.dart';
import 'package:corrida_da_fisica_web/model/Player.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:flutter/material.dart';

import '../../model/Question.dart';
import '../../model/Team.dart';
import '../../model/game_state.dart';
import '../../utils/utils.dart';

class GameRepository extends ChangeNotifier{

  String? gameCode;
  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [ Team("AAA", "player_icon_1.png", Player("aluno 1","jbasdj"), "sjksadjkads")];
  int numberOfTeams = 0;
  int maxPlayerNumber = 2;
  Board board = Board();
  GameState gameState = GameState.waiting;
  bool isLoading = false;
  int rolledNumber = 1;
  int currentTeamTurn = 0;
  int currentPlayerTurn = 0;
  late Question question = Question("asaddas", ["answers","jja","jksajk","kjasjkdasjk"],"answers");

  changeTheme(ThemeData theme){
    board.switchTheme(theme);
  }

  Player getDiceRollingPlayer(){
    return teams[currentTeamTurn].players[currentPlayerTurn];
  }

  Team getPlayingTeam(){
    return teams[currentTeamTurn];
  }


  loadImages() async{

    isLoading = true;
    await loadBoardImage();
    await loadTeamImages();
    isLoading = false;
    notifyListeners();
  }

  loadBoardImage() async{
    isLoading = true;
    if (board.loadedImage == null || board.imageAltered) {
      var boardImage = await loadImage(board.boardImage);

      if (boardImage != null) {
        board.setImage(boardImage);
        board.setImageAltered(false);
      } else {
        throw Exception("Board image could not be loaded");
      }
    }
    isLoading = false;
    notifyListeners();
  }

  loadTeamImages() async{
    isLoading = true;
    for (var element in teams) {
      if (element.loadedImage == null || element.imageAltered) {
        var image = await loadImage("assets/images/icons/${element.image}");
        if (image != null) {
          element.setImage(image);
          element.setImageAltered(false);
        } else {
          throw Exception(
              "Team image for team ${element.id} could not be loaded");
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

}