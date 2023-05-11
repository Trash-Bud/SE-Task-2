import 'package:corrida_da_fisica_web/view/components/header.dart';
import 'package:corrida_da_fisica_web/view/pages/rules_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Row(
          children: [getBoard(context), getButton(context)],
        ));
  }

  Widget getBoard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Image.asset("assets/images/basic_board.png"),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width / 2,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            width: 500,
            child: ElevatedButton(
                onPressed: () => {},
                child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Criar Novo Jogo"),
                )
            )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RulesPage()),
                  )},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Regras"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Créditos"),
                  )
              )
          ),
        ],

      ),
    );
  }
}
