import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Team.dart';

class TeamWaitPage extends StatelessWidget {
  const TeamWaitPage({super.key});

  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context, listen: false);
    switch (game.nextPage){

      case PageToGo.rollDice:
        Navigator.of(context).pushNamed("/roll_dice");
        break;
      case PageToGo.waitTurn:
        Navigator.of(context).pushNamed("/roll_dice");
        break;
      case PageToGo.none:
        break;
      default:
        break;
    }
    var teamID = game.player.getTeamID();
    var team = game.teams.where((element) => element.id == teamID).first;
    return Scaffold(
        appBar: AppBar(
            title: Row(children: [
              Provider.of<GameRepository>(context).player.getPfp(),
              const SizedBox(width: 10,),
              const Text("Corrida da Física",
                  textAlign: TextAlign.center)
            ]),
            automaticallyImplyLeading: false
        ),
        body: Column(
          children: [getTeamImage(context, team), getTeamName(context, team), getButton(context)],
        ));
  }

  Widget getTeamImage(BuildContext context, Team team) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0,20,0,0),
        child: GFAvatar(
          radius: 40,
          backgroundImage:
          ExactAssetImage(team.image),
          shape: GFAvatarShape.standard,
        )
    );
  }

  Widget getTeamName(BuildContext context, Team team) {
    return Container(
      height: MediaQuery.of(context).size.height/5,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Text(team.getName(),
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.bold)),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Aguarda pelo início do jogo...",
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20)),
          const SizedBox(height: 40,),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Provider.of<GameRepository>(context, listen: false).leaveTeam(), Navigator.of(context).pop()},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("Sair da equipa", style: TextStyle(color: Theme.of(context).colorScheme.secondary )),
                  )
              )
          ),
        ],

      ),
    );
  }
}
