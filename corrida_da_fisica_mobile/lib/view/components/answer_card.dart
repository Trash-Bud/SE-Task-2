import 'package:corrida_da_fisica_mobile/model/Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Player.dart';
import '../../utils/constants.dart';

class AnswerCard extends StatefulWidget {
  const AnswerCard({super.key, required this.question});

  final Question question;

  @override
  _AnswerCard createState() => _AnswerCard(question);
}

class _AnswerCard extends State<AnswerCard> {
  _AnswerCard(this.question);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor, width: 3),
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.height - 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getQuestion(context),
            getList(context),
          ],
        ));
  }

  getQuestion(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20), bottom: Radius.zero)),
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            question.question,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ));
  }

  getList(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView(shrinkWrap: true, children: getAnswers(context)),
    );
  }

  List<Widget> getAnswers(BuildContext context) {
    List<Widget> answers = [];
    int i = 0;
    for (var answer in question.answers.keys) {
      answers.add(getAnswer(answer, i, question.correctAnswer,
          question.answers[answer]!, context));
      i++;
    }
    return answers;
  }

  Widget getAnswer(String text, int index, int answer, List<Player> players,
      BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ListTile(
            leading: Checkbox(
                value: index == answer ? true : false,
                onChanged: (v) {
                  setState(() => {});
                }),
            title: Text(
              text,
              style: TextStyle(
                color: index == answer
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.onError,
              ),
            )),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getPlayers(players),
          ),
        )
      ],
    );
  }


  List<Widget> getPlayers(List<Player> pList){
    List<Widget> players = [];
    for (var player in pList){
      players.add(
          SvgPicture.asset(
              'assets/svg/${player.image}.svg',
              colorFilter: ColorFilter.mode(colors[player.color], BlendMode.srcIn),
              width: 40
          )
      );
    }
    return players;
  }
}
