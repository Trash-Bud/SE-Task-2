import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';

import '../model/Board.dart';
import '../model/Team.dart';
import '../utils/constants.dart';


class BoardViewCanvas extends CustomPainter {

  final Board board;
  final List<Team> teams;

  BoardViewCanvas(this.board, this.teams);

  @override
  void paint(Canvas canvas, Size size) {
    drawBoard(canvas);
    List<int> usedTiles = [];
    for (var team in teams){
      drawTeam(canvas,team,usedTiles);
      usedTiles.add(team.square);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawBoard(Canvas canvas) {
    var rect = Rect.fromCenter(center: boardOffset, width: boardSize, height: boardSize);
    paintImage(board.loadedImage!,rect,canvas,Paint(),BoxFit.contain);
  }

  void drawTeam(Canvas canvas, Team team,List<int> usedTiles) {

    var find = usedTiles.firstWhere((element) => element == team.square, orElse: () => -1);
    var offset = boardTiles[team.square];

    if (find != -1){
      offset = Offset(offset.dx+10, offset.dy+10);

    }

    var rect = Rect.fromCenter(center: offset, width: boardIconSize, height: boardIconSize);

    paintImage(team.loadedImage!,rect,canvas,Paint(),BoxFit.contain);
  }


  void paintImage(ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect = Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect = Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
  }

}