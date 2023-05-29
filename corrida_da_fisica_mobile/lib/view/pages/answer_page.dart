import 'package:corrida_da_fisica_mobile/view/components/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Question.dart';

class AnswerPage extends StatelessWidget {
  AnswerPage({super.key});



  Question question = Question(
      "Uma galáxia é",
      ["um enorme agrupamento de estrelas, gases e poeiras", "um enxame de estrelas", " um superenxame de estrelas", "um conjunto de asteroides"],
      "um enorme agrupamento de estrelas, gases e poeiras");

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
        body:
        getCard(context)
    );
  }

  Widget getCard(BuildContext context) {
    return AnswerCard(question: question);
  }

}
