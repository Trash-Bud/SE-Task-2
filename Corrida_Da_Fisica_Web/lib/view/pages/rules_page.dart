import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/page_header.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPage();
}

class _RulesPage extends State<RulesPage> {
  int page = 1;
  int max_pages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: getPage(),
    );
  }

  Widget getPage(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title:"Regras", path: "/"),
        if (page == 1) getPageOne(),
        if (page == 2) getPageTwo(),
        if (page == 3) getPageThree(),
        getFooter()
      ],
    );
  }

  back(){
    setState(() {
      if (page > 1) page --;
    });
  }

  next(){
    setState(() {
      if (page < max_pages) page ++;
    });
  }

  Widget getFooter(){
    return Container( margin: const EdgeInsets.all(10), child: Row(children: [
      if (page > 1) IconButton(onPressed: () => back(), icon:  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,)),
      Container(margin: const EdgeInsets.fromLTRB(5, 0, 5, 0), child: Text("$page / $max_pages", style: TextStyle(fontSize: 20,  color: Theme.of(context).primaryColor))),
      if (page < max_pages) IconButton(onPressed: () => next(), icon: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor))
    ],));
  }

  Widget getPageOne(){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  child: const Flexible(
                      child: Text("O jogo consiste num tabuleiro e num conjunto de cartas com perguntas sobre Física", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                    ),
                ),
                const SizedBox(height: 30,),
                SizedBox(height: 300,  child: Image.asset("assets/images/rules/board_and_cards.png"))
              ],
            ),
          ),

        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: const Flexible(
                  child: Text("Cada equipa/jogador rola um dado para definir o número de casas que vai avançar no tabuleiro", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/rules/dice.png"))
            ],
          ),
        ),
      ],
    );
  }

  Widget getPageTwo(){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: const Flexible(
                  child: Text("Após rolar o dado é dada uma pergunta à equipa/jogador e esta só poderá avançar se acertar na pergunta", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/rules/card.png"))
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 40,
                child: const Flexible(
                  child: Text("Se a equipa estiver numa casa especial...", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/rules/special_squares.png"))
            ],
          ),
        ),
      ],
    );
  }

  Widget getPageThree(){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 40,
                child: const Flexible(
                  child: Text("No caso de um jogo em equipas a resposta final é aquela que foi dada pela maioria jogadores da equipa", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 250,  child: Image.asset("assets/images/rules/card_answer.png"))
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 40,
                child: const Flexible(
                  child: Text("No caso de empate são dados 60 segundos à equipa para discutir a sua resposta", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/rules/draw.png"))
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 40,
                child: const Flexible(
                  child: Text("Ganha o jogo a primeira equipa/jogador a chegar ao fim do tabuleiro ", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 250,  child: Image.asset("assets/images/rules/win.png"))
            ],
          ),
        ),
      ],
    );
  }
}
