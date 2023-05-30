import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/BoardViewCanvas.dart';
import '../../controller/repository/GameRepository.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidget();
}

class _BoardWidget extends State<BoardWidget> {

  @override
  void initState() {
    super.initState();

    context.read<GameRepository>().loadImages();
  }

  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context);

    if (game.boardIsLoading){
      return const Center(child: CircularProgressIndicator());
    }

    return CustomPaint( painter: BoardViewCanvas(game.board, game.teams), child: Container());
  }
}
