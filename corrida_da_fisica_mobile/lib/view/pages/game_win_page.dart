import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class GameWinPage extends StatelessWidget {
  const GameWinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(children: [
              Provider.of<GameRepository>(context).player.getPfp(),
              const SizedBox(width: 10),
              const Text("Corrida da Física",
                  textAlign: TextAlign.center)
            ]),
            automaticallyImplyLeading: false
        ),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Column(
          children: [getBadge(context), getText(context), getButton(context)],
        ));
  }

  Widget getText(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 30,
      child: Column(
        children: const [
          Text("Parabéns!",
            style: TextStyle( fontSize: 80, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text("A tua equipa venceu o jogo",
            style: TextStyle( fontSize: 30, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ],
      )
    );
  }

  Widget getBadge(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/4+15,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Image.asset('assets/images/first_place.png'),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/scores")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Ver resultados"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(10),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {/*apagar content do repositorio*/Navigator.of(context).pushNamed("/")},
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.tertiary)),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("Sair", style: TextStyle(color: Theme.of(context).colorScheme.secondary ),),
                  )
              )
          ),
        ],
      ),
    );
  }
}
