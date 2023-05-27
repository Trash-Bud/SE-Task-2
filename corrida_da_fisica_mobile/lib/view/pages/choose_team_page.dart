import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

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
      _teamController = 0;
    });
  }

  static late int _teamController;
  static bool isLeader = false;

  void updateData() {
    //var game = Provider.of<GameRepository>(context);
    var game = Provider.of<GameRepository>(context, listen: false);
    game.player.setTeam(_teamController, isLeader);
    if (isLeader) {
      Navigator.of(context).pushNamed("/team_wait_leader");
    } else {
      Navigator.of(context).pushNamed("/team_wait");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(children: [
                Image.asset(Provider.of<GameRepository>(context).getPfp(), width:50),
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
          Text("Escolhe uma equipa",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              )
          ),
          Column(
              children: getTeams(context)
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
    List<Widget> teams = [];
    for (int i = 1; i < 5; i++) {
      teams.add(
            Container(
                margin: const EdgeInsets.all(10),
                width: 500,
                child: OutlinedButton(
                    onPressed: () => {setState(() => _teamController = i)},
                    style: ButtonStyle(
                        backgroundColor: _teamController == i ?
                        const MaterialStatePropertyAll<Color>(Color.fromRGBO(255, 251, 236, 1)) : const MaterialStatePropertyAll<Color>(Colors.white)),
                    child: Row(
                        children: [
                          Image.asset("assets/images/team/pfp$i.png", width:50),
                          const SizedBox(width: 5,),
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Text("Equipa $i"),
                          )
                        ])
                    )
            )
      );
    }
    return teams;
  }
}
