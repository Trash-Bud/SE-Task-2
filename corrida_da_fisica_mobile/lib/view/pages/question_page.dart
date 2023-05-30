import 'package:corrida_da_fisica_mobile/view/components/question_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Question.dart';

class QuestionPage extends StatelessWidget {
   QuestionPage({super.key});

   late Question question;

  @override
  Widget build(BuildContext context) {
    question = Provider.of<GameRepository>(context).question;

    var game = Provider.of<GameRepository>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (game.nextPage) {
        case PageToGo.waitAnswer:
          Navigator.of(context).pushNamed("/wait_answer");
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
        body:
            getCard(context)
        );
  }

  Widget getCard(BuildContext context) {
    return QuestionCard(question: question);
  }

}
