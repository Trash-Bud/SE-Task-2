import 'package:corrida_da_fisica_web/model/Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {super.key, required this.question, required this.showAnswer});

  final bool showAnswer;
  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.height - 50,
        height: MediaQuery.of(context).size.height - 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [getQuestion(context), getAnswers(context)],
        ));
  }

  getQuestion(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20), bottom: Radius.zero)),
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            question.question,
            style: const TextStyle(color: Colors.white, fontSize: 40),
          ),
        ));
  }

  getAnswers(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: getOptionsList(context),
        ));
  }

  List<Widget> getOptionsList(BuildContext context) {
    List<Widget> widgets = [];
    var index = 0;
    for (var element in question.answers.entries) {
      widgets.add(getAnswer(element, index, context));
      index++;
    }

    return widgets;
  }

  Widget getAnswer(MapEntry option, int index, BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Row(
            children: [Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Checkbox(
                value: (showAnswer && index == question.correctAnswer), onChanged: (bool? value) {  },
                checkColor: Theme.of(context).colorScheme.secondary,
                fillColor:  MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
              ),
            ),
              Flexible(
                child: Text(
                  option.key,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary, fontSize: 20),
                ),
              ),],
          ),
          Row(
            children: option.value.map<Widget>((val) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: SvgPicture.asset(
                  "assets/images/icons_players/${val.image}",
                  color: pfPicColors[val.color],
                  width: 20,
                  semanticsLabel: 'A red up arrow'),
            )).toList(),
          )
        ]));
  }
}
