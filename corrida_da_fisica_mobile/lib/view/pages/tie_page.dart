import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class TiePage extends StatelessWidget {
  TiePage({super.key});


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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                  "Uh oh! Empate!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            const SizedBox(height: 20,),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20), bottom: Radius.circular(20))),
                width: MediaQuery.of(context).size.width-100,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const Text(
                    "A tua equipa não concordou em uma resposta para a questão anterior.",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                )),
            const SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width-50,
              child: Text(
                  "Têm 60 segundos para discutir as respostas!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          ],
        )
    );
  }


}
