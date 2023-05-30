

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import '../utils/themes.dart';

class Board {
  ThemeData theme = defaultTheme;
  late String boardImage = "assets/images/basic_board.png";
  ui.Image? loadedImage;
  bool imageAltered = true;
  static const List<int> twoQuestions = [1,12,24,36,48,60];
  static const List<int> changeQuestion = [8,20,32,44,56,67];
  static const List<int> twoChances = [4,16,28,40,52,63];

  void switchTheme(ThemeData newTheme) {
    theme = newTheme;

    if (newTheme == defaultTheme){
      boardImage = "assets/images/basic_board.png";
    }else if (newTheme == seventhGradeTheme){
      boardImage = "assets/images/seventh_grade_board.png";
    }else{
      boardImage = "assets/images/basic_board.png";
    }
    imageAltered = true;

  }

  setImageAltered(bool imageAltered ){
    imageAltered = imageAltered;
  }

  checkIfTileIsTwoQuestionsTile(tile){
    return (twoQuestions.firstWhere((element) => element == tile, orElse: () => -1) != -1);
  }
  checkIfTileChangeQuestionTile(tile){
    return (changeQuestion.firstWhere((element) => element == tile, orElse: () => -1) != -1);
  }
  checkIfTileTwoChancesTile(tile){
    return (twoChances.firstWhere((element) => element == tile, orElse: () => -1) != -1);
  }


  setImage(ui.Image image){
    loadedImage = image;
  }

}
