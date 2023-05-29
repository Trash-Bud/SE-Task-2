import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  RulesPage({super.key});


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
              Text("Regras",
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
                    child: Image.asset("assets/images/rules/rules.png"),
                  )
              )
          ),
        ],

      ),
    );
  }
}
