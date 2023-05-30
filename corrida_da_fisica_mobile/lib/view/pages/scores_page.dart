import 'package:corrida_da_fisica_mobile/view/components/score_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Score.dart';

class ScoresPage extends StatelessWidget {
  ScoresPage({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: getScores(context));
  }

  Widget getScores(BuildContext context) {
    var game = Provider.of<GameRepository>(context,listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Resultados",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {Navigator.of(context).pop();}
                  )
                ],
          ),
          Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      children: game.scores.map((e) => ScoreCard(score: e)).toList()
                    )

          )
        ],

      ),
    );
  }
}
