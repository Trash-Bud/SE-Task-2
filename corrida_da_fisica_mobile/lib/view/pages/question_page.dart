import 'package:corrida_da_fisica_mobile/view/components/question_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Question.dart';

class QuestionPage extends StatelessWidget {
   QuestionPage({super.key});



  Question question = Question(
      "Uma galáxia é",
      ["um enorme agrupamento de estrelas, gases e poeiras", "um enxame de estrelas", " um superenxame de estrelas", "um conjunto de asteroides"],
      0);

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
    return QuestionCard(question: question);
  }

}
