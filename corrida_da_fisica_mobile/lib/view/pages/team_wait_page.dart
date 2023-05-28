import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class TeamWaitPage extends StatelessWidget {
  const TeamWaitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [getTeamImage(context), getTeamName(context), getButton(context)],
        ));
  }

  Widget getTeamImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/5,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Image.asset("assets/images/team/pfp${Provider.of<GameRepository>(context, listen: false).player.getTeamID().toString()}.png"),
    );
  }

  Widget getTeamName(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/5,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Text("Equipa ${Provider.of<GameRepository>(context, listen: false).player.getTeamID().toString()}",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.bold)),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: const Text("Sair da equipa"),
                  )
              )
          ),
        ],

      ),
    );
  }
}
