import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/repository/GameRepository.dart';
import '../components/app_bar.dart';
import '../components/page_header.dart';

class GameWaitPage extends StatefulWidget {
  const GameWaitPage({super.key});

  @override
  State<GameWaitPage> createState() => _GameWaitPage();
}

class _GameWaitPage extends State<GameWaitPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    context.read<GameRepository>().endGame();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Header(title: "Jogo", path: "/"),
          getPage(game),
          getStartButton(game)
        ],
      ),
    );
  }


  getStartButton(GameRepository game) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if(game.pendingPlayers.isEmpty && game.checkIfAllTeamsHavePeople()){
            game.lockGame();
            Navigator.of(context).pushNamed("/game");
          }
        },
        child: (game.pendingPlayers.isEmpty && game.checkIfAllTeamsHavePeople()) ? const Text("Começar") : const Text("À espera...")
      ),
    );
  }

  getPage(GameRepository game) {

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [getCode(game), getPlayers(game)],
      ),
    );
  }

  getCode(GameRepository game) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "O código do jogo é:",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          getCodeContainer(game),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Partilhe o código com os alunos para eles se juntarem ao jogo.",
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
          TextButton(
              onPressed: () => {
                Navigator.of(context).pushNamed("/how_connect")
              },
              child: Text(
                "Como é que se entra no jogo?",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }

  getPlayers(GameRepository game) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 20,
      height: MediaQuery.of(context).size.width / 4,
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: getAllPlayers(game)),
      ),
    );
  }

  getAllPlayers(GameRepository game) {
    List<Widget> players = [];

    players.add(
      Text(
        "Já está cá...",
        style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 40,
            fontWeight: FontWeight.bold),
      ),
    );

    for (var team in game.teams) {
      for (var player in team.players) {
        players.add(Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ Icon(Icons.done, color: Theme.of(context).colorScheme.tertiary),Text(
              player.name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 20))],
            ),
          ),
        );
      }
    }

    for (var player in game.pendingPlayers) {
        players.add(Container(
          padding: const EdgeInsets.all(5),
          child: Text(
                player.name,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary, fontSize: 20)),
        ),
        );
    }


    return players;
  }

  getCodeContainer(GameRepository game) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border:
            Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
      ),
      width: MediaQuery.of(context).size.width / 3,
      child: (!game.isLoading) ? Text(
        game.gameCode,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 35,
            fontWeight: FontWeight.bold),
      ) : const SizedBox(width: 20,child: CircularProgressIndicator(),)
    );
  }
}
