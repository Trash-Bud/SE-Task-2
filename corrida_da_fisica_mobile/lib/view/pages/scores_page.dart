import 'package:corrida_da_fisica_mobile/view/components/score_card.dart';
import 'package:flutter/material.dart';

import '../../model/Score.dart';

class ScoresPage extends StatelessWidget {
  ScoresPage({super.key});

  List<Score> scores = [
    Score(1, 3, 10, 8, 2),
    Score(2, 2, 10, 7, 3),
    Score(3, 4, 10, 6, 4),
    Score(4, 1, 10, 5, 5),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: getScores(context));
  }

  Widget getScores(BuildContext context) {
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
                      children: scores.map((e) => ScoreCard(score: e)).toList()
                    )

          )
        ],

      ),
    );
  }
}
