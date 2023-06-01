import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/get_rule_section.dart';
import '../components/page_header.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPage();
}

class _RulesPage extends State<RulesPage> {
  int page = 1;
  int maxPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: getPage(),
    );
  }

  Widget getPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title: "Regras", path: "/"),
        if (page == 1) getPageOne(),
        if (page == 2) getPageTwo(),
        if (page == 3) getPageThree(),
        getFooter()
      ],
    );
  }

  back() {
    setState(() {
      if (page > 1) page--;
    });
  }

  next() {
    setState(() {
      if (page < maxPages) page++;
    });
  }

  Widget getFooter() {
    return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (page > 1)
              IconButton(
                  onPressed: () => back(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  )),
            Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text("$page / $maxPages",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor))),
            if (page < maxPages)
              IconButton(
                  onPressed: () => next(),
                  icon: Icon(Icons.arrow_forward,
                      color: Theme.of(context).primaryColor))
          ],
        ));
  }

  Widget getPageOne() {
    return Row(
      children: [
        RuleSection(
            width: MediaQuery.of(context).size.width / 2 - 40,
            text:
                "O jogo consiste num tabuleiro e num conjunto de cartas com perguntas sobre Física",
            image: "assets/images/rules/board_and_cards.png"),
        RuleSection(
            width: MediaQuery.of(context).size.width / 2 - 40,
            text:
                "Cada equipa/jogador rola um dado para definir o número de casas que vai avançar no tabuleiro",
            image: "assets/images/rules/dice.png"),
      ],
    );
  }

  Widget getPageTwo() {
    return Row(
      children: [
        RuleSection(
            width: MediaQuery.of(context).size.width / 2 - 40,
            text:
            "Após rolar o dado é dada uma pergunta à equipa/jogador e esta só poderá avançar se acertar na pergunta",
            image: "assets/images/rules/card.png"),
        RuleSection(
            width: MediaQuery.of(context).size.width / 2 - 40,
            text:
            "Se a equipa estiver numa casa especial...",
            image: "assets/images/rules/special_squares.png"),
      ],
    );
  }

  Widget getPageThree() {
    return Row(
      children: [

        RuleSection(
            width: MediaQuery.of(context).size.width / 3 - 40,
            text:
            "No caso de um jogo em equipas a resposta final é aquela que foi dada pela maioria jogadores da equipa",
            image: "assets/images/rules/card_answer.png"),
        RuleSection(
            width: MediaQuery.of(context).size.width / 3 - 40,
            text:
            "No caso de empate são dados 60 segundos à equipa para discutir a sua resposta",
            image: "assets/images/rules/draw.png"),
        RuleSection(
            width: MediaQuery.of(context).size.width / 3 - 40,
            text:
            "Ganha o jogo a primeira equipa/jogador a chegar ao fim do tabuleiro ",
            image: "assets/images/rules/win.png"),
      ],
    );
  }
}
