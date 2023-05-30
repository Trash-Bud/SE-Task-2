import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class WaitAnswerPage extends StatefulWidget {
  WaitAnswerPage({super.key});

  @override
  _WaitAnswerPage createState() => _WaitAnswerPage();

}

class _WaitAnswerPage extends State<WaitAnswerPage>{
  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (game.nextPage) {
        case PageToGo.rollDice:
          Navigator.of(context).pushNamed("/roll_dice");
          break;
        case PageToGo.waitTurn:
          Navigator.of(context).pushNamed("/wait_turn");
          break;
        case PageToGo.answer:
          Navigator.of(context).pushNamed("/answer");
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
          child: Text(
              "Ainda têm tempo! Espere o resto da equipa responder",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              )
          ),
        )
    );
  }


}
