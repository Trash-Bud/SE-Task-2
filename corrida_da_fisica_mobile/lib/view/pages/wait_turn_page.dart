import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class WaitTurnPage extends StatelessWidget {
  WaitTurnPage({super.key});


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
        body: Container(
          alignment: Alignment.center,
          child: Text(
              "_ está a jogar",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              )
          ),
        )
    );
  }


}
