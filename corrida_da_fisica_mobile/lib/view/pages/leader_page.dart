import 'package:flutter/material.dart';

class LeaderPage extends StatelessWidget {
  LeaderPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 251, 236, 1),
        body: getInstructions(context));
  }

  Widget getInstructions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("O que é o líder da equipa?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 30,
                            fontWeight: FontWeight.bold))
                    ,
                    IconButton(
                        icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
                        onPressed: () {Navigator.of(context).pop();}
                    )
                  ]
              )
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset("assets/images/rules/leader.png"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/create_code")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Deixar de ser líder"),
                  )
              )
          ),
        ],

      ),
    );
  }
}