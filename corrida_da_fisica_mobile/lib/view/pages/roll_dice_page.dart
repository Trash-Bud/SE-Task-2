import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class RollDicePage extends StatelessWidget {
  const RollDicePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [getText(context), getDice(context), getButton(context)],
        ));
  }

  Widget getText(BuildContext context){
    return Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 30,
        child: Text("É o teu turno de rolar o dado",
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 40, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
    );
  }

  Widget getDice(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/4,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: SvgPicture.asset(
          'assets/svg/dice.svg',
          colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
          height: MediaQuery.of(context).size.height/4
      ),
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
          Container(
              margin: const EdgeInsets.all(10),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {
                    Provider.of<GameRepository>(context, listen: false).rollDice(),
                    Navigator.of(context).pushNamed("/wait_turn")
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Rolar"),
                  )
              )
          ),
        ],
      ),
    );
  }
}
