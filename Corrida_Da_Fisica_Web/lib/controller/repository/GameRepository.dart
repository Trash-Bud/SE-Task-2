
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:corrida_da_fisica_web/model/Board.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:flutter/cupertino.dart';

import '../../model/Player.dart';
import '../../model/Team.dart';
import '../../utils/utils.dart';

class GameRepository extends ChangeNotifier{

  AppTheme appTheme = AppTheme.defaultTheme;
  List<Team> teams = [ ];
  int numberOfThemes = 0;
  Board board = Board();
  bool isLoading = false;


  loadImages() async{

    isLoading = true;
    if(board.loadedImage == null) {
      await loadBoardImage();
    }
    if(teams[0].loadedImage == null) {
      await loadTeamImages();
    }
    isLoading = false;
    notifyListeners();
  }

  loadBoardImage() async{
    isLoading = true;
    var boardImage = await loadImage(board.boardImage);
    isLoading = false;

    if (boardImage != null){
      board.setImage(boardImage);
    }else{
      throw Exception("Board image could not be loaded");
    }
    notifyListeners();
  }

  loadTeamImages() async{
    isLoading = true;

    for (var element in teams) {
      var image = await loadImage("assets/images/icons/${element.image}");
      if (image != null){
        element.setImage(image);
      }else{
        throw Exception("Team image for team ${element.id} could not be loaded");
      }
    }

    isLoading = false;
    notifyListeners();
  }

}