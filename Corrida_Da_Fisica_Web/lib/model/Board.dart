
import 'dart:ui';

import '../utils/themes.dart';

class Board {
  AppTheme theme = AppTheme.defaultTheme;
  late String boardImage = "assets/images/basic_board.png";
  Image? loadedImage;
  bool imageAltered = true;

  void switchTheme(AppTheme newTheme) {
    theme = newTheme;
    switch (newTheme) {
      case AppTheme.defaultTheme:
        boardImage = "assets/images/basic_board.png";
        break;
      case AppTheme.seventhGradeTheme:
        boardImage = "assets/images/seventh_grade_board.png";
        break;
      default:
        boardImage = "assets/images/basic_board.png";
        break;
    }
  }

  setImageAltered(bool imageAltered ){
    imageAltered = imageAltered;
  }


  setImage(Image image){
    loadedImage = image;
  }

}
