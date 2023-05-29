import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class TeamWaitPage extends StatelessWidget {
  const TeamWaitPage({super.key});

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
        body: Column(
          children: [getTeamImage(context), getTeamName(context), getButton(context)],
        ));
  }

  Widget getTeamImage(BuildContext context) {
    var teamID = Provider.of<GameRepository>(context, listen: false).player.getTeamID();
    return Padding(
        padding: const EdgeInsets.fromLTRB(0,20,0,0),
        child: GFAvatar(
          radius: 40,
          backgroundImage:
          ExactAssetImage(Provider.of<GameRepository>(context, listen: false).getTeams()[teamID-1].image),
          shape: GFAvatarShape.standard,
        )
    );
  }

  Widget getTeamName(BuildContext context) {
    var teamID = Provider.of<GameRepository>(context, listen: false).player.getTeamID();
    return Container(
      height: MediaQuery.of(context).size.height/5,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Text(Provider.of<GameRepository>(context, listen: false).getTeams()[teamID-1].getName(),
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
                  onPressed: () => {Navigator.of(context).pushNamed("/create_code")},
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
