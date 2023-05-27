import 'package:corrida_da_fisica_web/model/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../controller/repository/GameRepository.dart';
import '../components/app_bar.dart';
import '../components/board_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePage();
}

class _GamePage extends State<GamePage> {
  String assetName = "assets/images/dice/dice.svg";
  int winner = 0;

  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [getBoard(), getWaitRollDice(game)],
      ),
    );
  }

  Widget getBoard() {
    return Container(
        width: MediaQuery.of(context).size.width / 2,
        alignment: Alignment.center,
        child: const BoardWidget());
  }

  getCurrentPlayerIcon(GameRepository game) {
    return Image.asset(
      "assets/images/icons/${game.getPlayingTeam().image}",
      scale: 5,
    );
  }

  getWinningPlayerIcon(GameRepository game) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Image.asset(
        "assets/images/icons/${game.teams[winner].image}",
        scale: 5,
      ),
    );
  }

  getDice() {
    return SvgPicture.asset(assetName,
        color: Theme.of(context).primaryColor,
        width: 200,
        semanticsLabel: 'A red up arrow');
  }

  getTurn(GameRepository game) {
    return Text(
      "É a vez dos ${game.getPlayingTeam().name}!",
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
  }

  getWinningPlayerName(GameRepository game) {
    return Text(
      "Os ${game.teams[winner].name} venceram!",
      style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
  }

  Widget getWaitRollDice(GameRepository game) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.center,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildPageWidgets(game)),
    );
  }

  backToMenuButton(){
    return Container(
      margin: const EdgeInsets.all(20),
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () => {
          Navigator.of(context).pushNamed("/")
        },
        child: const Text("Voltar para o menu"),
      ),
    );
  }

  buildPageWidgets(GameRepository game) {
    List<Widget> list = [];
    if (game.gameState == GameState.gameEnd) {
      list.add(getWinningTitle());
      list.add(getWinningPlayerName(game));
      list.add(getWinningPlayerIcon(game));
      list.add(backToMenuButton());
    }

    if (game.gameState != GameState.gameEnd) {
      list.add(getCurrentPlayerIcon(game));
      list.add(getTurn(game));
    }
    if (game.gameState == GameState.waitingDice ||
        game.gameState == GameState.rolledDice) {
      getDiceScreen(game).forEach((e) => list.add(e));
    }
    return list;
  }

  getWinningTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/throphy.svg",
          width: 80,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Text(
          "Parabéns!",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 80,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  List<Widget> getDiceScreen(GameRepository game) {
    return [
      getDiceText(game),
      const SizedBox(
        height: 30,
      ),
      getDice()
    ];
  }

  getDiceText(GameRepository game) {
    return game.gameState == GameState.rolledDice
        ? Text(
            "Saio-te um ${game.rolledNumber}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20,
            ),
          )
        : Text(
            "${game.getDiceRollingPlayer().name}, quando estiveres pronto(a) rola o dado!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20,
            ),
          );
  }
}
