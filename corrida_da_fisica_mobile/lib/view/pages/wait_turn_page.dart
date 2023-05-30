import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class WaitTurnPage extends StatefulWidget {
  WaitTurnPage({super.key});


  @override
  _WaitTurnPage createState() => _WaitTurnPage();

}

class _WaitTurnPage extends State<WaitTurnPage>{
  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context, listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (game.nextPage) {
        case PageToGo.rollDice:
          Navigator.of(context).pushNamed("/roll_dice");
          break;
        case PageToGo.question:
          Navigator.of(context).pushNamed("/question");
          break;
        case PageToGo.none:
          break;
        default:
          break;
      }
    });
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
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Estás no jogo!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  )
              ),
              Text("Aguarda a tua vez",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20)),
            ],
          )
        )
    );
  }


}
