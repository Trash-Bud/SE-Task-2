import 'package:corrida_da_fisica_mobile/model/Question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({super.key, required this.question});
  final Question question;

  @override
  _QuestionCard createState() => _QuestionCard(question);

}

class _QuestionCard extends State<QuestionCard>{
  _QuestionCard(this.question);

  String? _responseController;
  final Question question;

  void updateData(){
    var game = Provider.of<GameRepository>(context, listen: false);
    if (_responseController != null) {
      game.lastAnswer = int.parse(_responseController!);
    }
    else {
      game.lastAnswer = -1;
    }

    Navigator.of(context).pushNamed("/wait_answer");
  }

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
        getAnswer(question.answers[i], i, context)
      );
    }
    return answers;
  }


  Widget getAnswer(String text, int index, BuildContext context) {
    return RadioListTile(
        title: Text(text,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        value: "$index",
        groupValue: _responseController,
        onChanged: (v){ setState(() => _responseController = v.toString()); }
    );
  }


  Widget getButton(BuildContext context) {
    return
      Container(
          margin: const EdgeInsets.all(20),
          width: 500,
          child: ElevatedButton(
              onPressed: () => {updateData()},
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const Text("Guardar"),
              )
          )
      );
  }
}
