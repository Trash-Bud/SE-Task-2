import 'package:corrida_da_fisica_mobile/model/Question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class AnswerCard extends StatefulWidget {
  const AnswerCard({super.key, required this.question});
  final Question question;

  @override
  _AnswerCard createState() => _AnswerCard(question);

}

class _AnswerCard extends State<AnswerCard>{
  _AnswerCard(this.question);

  final Question question;


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.height - 50,
              height: MediaQuery.of(context).size.height - 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [getQuestion(context), getList(context), ],
              )
          ),
          getButton(context)
        ]
    );
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
      padding: const EdgeInsets.fromLTRB(0,10,0,0),
      child: ListView(
          shrinkWrap: true,
          children: getAnswers(context)
      ),
    );
  }

  List<Widget> getAnswers(BuildContext context){
    List<Widget> answers = [];
    for (int i = 0; i < question.answers.length; i++){
      answers.add(
          getAnswer(question.answers[i], i, question.correctAnswer, context)
      );
    }
    return answers;
  }


  Widget getAnswer(String text, int index, String answer, BuildContext context) {
    return
      ListTile(
        leading:Checkbox(
        value: text == answer ? true : false,
        onChanged: (v){ setState(() => {}); }
        ),
        title: Text(text,
          style: TextStyle(color: text == answer ? Theme.of(context).primaryColor : Color.fromRGBO(239, 186, 129, 1), fontSize: 20,),
        ),
      );
  }


  Widget getButton(BuildContext context) {
    return
      Container(
          margin: const EdgeInsets.all(20),
          width: 500,
          child: ElevatedButton(
              onPressed: () => {Navigator.of(context).pushNamed("/wait_turn")},
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const Text("Avançar"),
              )
          )
      );
  }
}
