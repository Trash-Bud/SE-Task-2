import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Team.dart';

class ChooseTeamPage extends StatefulWidget {
  ChooseTeamPage({super.key});


  @override
  _ChooseTeamPage createState() => _ChooseTeamPage();

}

class _ChooseTeamPage extends State<ChooseTeamPage>{
  @override
  void initState() {
    super.initState();
    setState(() {
      _teamController = "";
    });
  }


  List<Color> colors = [
    Colors.orange,
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.pinkAccent,
    Colors.tealAccent,
    Colors.deepPurpleAccent,
    Colors.yellow
  ];

  static late String _teamController;

  Future<void> updateData() async {
    //var game = Provider.of<GameRepository>(context);
    var game = Provider.of<GameRepository>(context, listen: false);
    if (_teamController != "") {
      game.player.setTeam(_teamController);

      await game.joinTeam();
      if (game.player.isLeader) {
        Navigator.of(context).pushNamed("/team_wait_leader");
      } else {
        Navigator.of(context).pushNamed("/team_wait");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
                Provider.of<GameRepository>(context).player.getPfp(),
                const SizedBox(width: 25,),
                const Text("A Corrida da Física",
                  textAlign: TextAlign.center)
                ]),
          automaticallyImplyLeading: false
          ),
        body: getButton(context));
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Escolhe uma equipa",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              )
          ),
          Expanded(
          child: ListView(
              shrinkWrap: true,
              children: getTeams(context)
              )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {updateData()},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Confirmar"),
                  )
              )
          ),
        ],

      ),
    );
  }

  List<Widget> getTeams(BuildContext context) {
    var gameTeams = Provider.of<GameRepository>(context, listen: false).getTeams();
    List<Widget> teams = [];
    for (int i = 0; i < gameTeams.length; i++) {
      teams.add(
            Container(
                margin: const EdgeInsets.all(10),
                width: 500,
                child: OutlinedButton(
                    onPressed: () => {setState(() => _teamController = gameTeams[i].id)},
                    style: ButtonStyle(
                        backgroundColor: _teamController == gameTeams[i].id ?
                        MaterialStateProperty.all(Theme.of(context).colorScheme.tertiary) : MaterialStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                    ),
                    child:
                        Row(
                            children: [
                              Image.asset(gameTeams[i].getImage(), width:80),
                              const SizedBox(width: 5,),
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Text(gameTeams[i].getName(), style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontSize: 20)),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: getPlayers(gameTeams[i]),
                                  )
                                ])
                            ]),
                )
            )
      );
    }
    return teams;
  }

  List<Widget> getPlayers(Team team){
    List<Widget> players = [];
    for (var player in team.players){
      players.add(
          SvgPicture.asset(
                'assets/svg/${player.image}.svg',
                colorFilter: ColorFilter.mode(colors[player.color], BlendMode.srcIn),
                width: 50
          )
      );
    }
    return players;
  }
}
