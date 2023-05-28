

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import '../utils/themes.dart';

class Board {
  ThemeData theme = defaultTheme;
  late String boardImage = "assets/images/basic_board.png";
  ui.Image? loadedImage;
  bool imageAltered = true;

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


  setImage(ui.Image image){
    loadedImage = image;
  }

}
