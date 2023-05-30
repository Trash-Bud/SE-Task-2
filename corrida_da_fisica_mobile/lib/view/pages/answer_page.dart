import 'package:corrida_da_fisica_mobile/view/components/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Question.dart';

class AnswerPage extends StatelessWidget {
  AnswerPage({super.key});

  late Question question;

  @override
  Widget build(BuildContext context) {
    question = Provider.of<GameRepository>(context).question;
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
        body:
        getCard(context)
    );
  }

  Widget getCard(BuildContext context) {
    return AnswerCard(question: question);
  }

}
