import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class WaitAnswerPage extends StatelessWidget {
  WaitAnswerPage({super.key});


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
