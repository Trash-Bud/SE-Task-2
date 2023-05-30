import 'package:corrida_da_fisica_mobile/view/components/answer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Question.dart';

class AnswerPage extends StatefulWidget {
  AnswerPage({super.key});

  @override
  _AnswerPage createState() => _AnswerPage();

}

class _AnswerPage extends State<AnswerPage>{
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
        case PageToGo.gameWin:
          Navigator.of(context).pushNamed("/game_win");
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
    return AnswerCard(question: question);
  }

}
