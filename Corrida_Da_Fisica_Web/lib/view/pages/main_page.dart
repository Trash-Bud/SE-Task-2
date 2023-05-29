import 'package:corrida_da_fisica_web/controller/repository/GameRepository.dart';
import 'package:corrida_da_fisica_web/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/board_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Row(
          children: [getBoard(context), getButton(context)],
        ));
  }

  Widget getBoard(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width/2,
        alignment: Alignment.center,
        child: const BoardWidget());
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
                onPressed: () => {Navigator.of(context).pushNamed("/setup")},
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
                  onPressed: () => {Navigator.of(context).pushNamed("/rules")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Regras", style: TextStyle(color: Theme.of(context).colorScheme.secondary )),
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
                    child: const Text("Créditos", style: TextStyle(color: Theme.of(context).colorScheme.secondary )),
                  )
              )
          ),
        ],

      ),
    );
  }

}
