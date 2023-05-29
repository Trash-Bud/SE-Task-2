import 'package:corrida_da_fisica_web/model/Question.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.question});

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
          children:
              question.answers.map((e) => getAnswer(e, context)).toList()),
    );
  }

  Widget getAnswer(String text, BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Text(
      text,
      style:
          TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),
    ));
  }
}
