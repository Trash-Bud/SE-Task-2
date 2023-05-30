import 'dart:async';

import 'package:corrida_da_fisica_web/model/game_state.dart';
import 'package:corrida_da_fisica_web/view/components/question_card.dart';
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

  @override
  void initState() {
    if (!context.read<GameRepository>().won) {
      context.read<GameRepository>().chooseRoll();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context);

    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [getBoard(game), if (!game.isLoading) getPage(game)],
      ),
    );
  }

  Widget getBoard(GameRepository game) {
    if (game.gameState == GameState.question ||
        game.gameState == GameState.questionEnd) {
      if (game.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      return Container(
          width: MediaQuery.of(context).size.width / 2,
          alignment: Alignment.center,
          child: QuestionCard(
            question: game.question,
            showAnswer: game.gameState == GameState.questionEnd,
          ));
    }

    return Container(
        width: MediaQuery.of(context).size.width / 2,
        alignment: Alignment.center,
        child: const BoardWidget());
  }

  getCurrentPlayerIcon(GameRepository game) {
    return Image.asset(
      "assets/images/icons_teams/${game.getPlayingTeam().image}",
      scale: 5,
    );
  }

  getAnswerQuestion(GameRepository game) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        "Respondam a pergunta antes do tempo acabar.",
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 20,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        game.seconds.toString(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 15,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(20),
        child: LinearProgressIndicator(
          value: game.seconds / 30,
        ),
      ),
      if (!game.isReplacement && game.checkIfReplaceTile()) replaceCardButton(game)
    ]);
  }

  correctAnswerText(GameRepository game) {
    return Text(
      "Os ${game.getPlayingTeam().name} acertaram a pergunta!",
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 20,
      ),
    );
  }

  wrongAnswerText(GameRepository game) {
    return Text(
      "Os ${game.getPlayingTeam().name} erraram a pergunta",
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 20,
      ),
    );
  }

  getWinningPlayerIcon(GameRepository game) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Image.asset(
        "assets/images/icons_teams/${game.winner.image}",
        scale: 5,
      ),
    );
  }

  getDice(GameRepository game) {
    return game.gameState == GameState.rolledDice
        ? SvgPicture.asset("assets/images/dice/dice-${game.rolledNumber}.svg",
            color: Theme.of(context).primaryColor,
            width: 200,
            semanticsLabel: 'RolledDice')
        : SvgPicture.asset("assets/images/dice/dice.svg",
            color: Theme.of(context).primaryColor,
            width: 200,
            semanticsLabel: 'Hands with dice');
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
      "Os ${game.winner.name} venceram!",
      style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
  }

  Widget getPage(GameRepository game) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.center,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildPageWidgets(game)),
    );
  }


  replaceCardButton(GameRepository game){
    return Container(
      margin: const EdgeInsets.all(20),
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () => {
          game.replaceCard()},
        child: const Text("Trocar de pergunta"),
      ),
    );
  }

  backToMenuButton(GameRepository game) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 300,
      height: 60,
      child: ElevatedButton(
        onPressed: () => {
          Navigator.of(context).pushNamed("/")},
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
      list.add(backToMenuButton(game));
    }

    if (game.gameState != GameState.gameEnd) {
      list.add(getCurrentPlayerIcon(game));
      list.add(getTurn(game));
    }

    if (game.gameState == GameState.question) {
      list.add(getAnswerQuestion(game));
    }

    if (game.gameState == GameState.questionEnd) {
      if (game.questionWon) {
        list.add(correctAnswerText(game));
      } else {
        list.add(wrongAnswerText(game));
      }
      list.add(getContinueButton(game));
    }

    if (game.gameState == GameState.waitingDice ||
        game.gameState == GameState.rolledDice) {
      getDiceScreen(game).forEach((e) => list.add(e));
    }

    if (game.gameState != GameState.gameEnd) {
      list.add(getEndGameButton(game));
    }
    return list;
  }

  getContinueButton(GameRepository game) {
    return Container(
        margin: const EdgeInsets.all(20),
        width: 300,
        height: 60,
        child: ElevatedButton(
            onPressed: () => {
                  if (game.extraQuestion)
                    {game.getCard()}
                  else
                    {
                      game.changeCurrentTeam(),
                      game.chooseRoll(),
                    }
                },
            child: const Text("Continuar")));
  }

  getEndGameButton(GameRepository game) {
    return TextButton(
        onPressed: () => {Navigator.of(context).pushNamed("/")},
        child: const Text("Terminar o jogo"));
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
      getDice(game),
      if (game.gameState == GameState.rolledDice) getQuestionButton(game)
    ];
  }

  getQuestionButton(GameRepository game) {
    return Container(
        margin: const EdgeInsets.all(20),
        width: 300,
        height: 60,
        child: ElevatedButton(
            onPressed: () => {game.getCard()},
            child: const Text("Ver Questão")));
  }

  getDiceText(GameRepository game) {
    return game.gameState == GameState.rolledDice
        ? Text(
            "Saiu-te um ${game.rolledNumber}",
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
