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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Header(title: "Jogo", path: "/"),
          getPage(),
          getStartButton()
        ],
      ),
    );
  }

  getStartButton() {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/game");
          
        },
        child: const Text("Começar"),
      ),
    );
  }

  getPage() {
    var game = Provider.of<GameRepository>(context);
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
              onPressed: () => {},
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
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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
          child: Text(
            player.name,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, fontSize: 20),
          ),
        ));
      }
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
      child: Text(
        game.gameCode ?? "Placeholder",
        style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 35,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
