import 'package:corrida_da_fisica_web/model/Board.dart';
import 'package:corrida_da_fisica_web/model/Player.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:flutter/cupertino.dart';

import '../../model/Team.dart';
import '../../utils/utils.dart';

class GameRepository extends ChangeNotifier{

  String? gameCode;
  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [];
  int numberOfThemes = 0;
  Board board = Board();
  bool isLoading = false;
  int currentTurn = 0;

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