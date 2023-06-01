import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/get_rule_section.dart';
import '../components/page_header.dart';


class ConnectInstructionsPage extends StatelessWidget {
  const ConnectInstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: getPage(context),
    );
  }

  Widget getPage(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title:"Como se entra no jogo?", path: "/connect"),
        getContent(context)
      ],
    );
  }

  Widget getContent(BuildContext context){
    return Row(
      children: [

        RuleSection(
            width: MediaQuery.of(context).size.width / 3 - 40,
            text:
            "Aceder ao site \"corrida-da-fisica-mobile.web.app\" a partir de um dispositivo pessoal",
            image: "assets/images/join_instructions/main_screen.png"),
        RuleSection(
            width: MediaQuery.of(context).size.width / 3 - 40,
            text:
            "Precionar inserir código e inseri-lo no campo indicado",
            image: "assets/images/join_instructions/insert_code.png"),
        RuleSection(
            width: MediaQuery.of(context).size.width / 3 - 40,
            text:
            "Clicar em começar o jogo",
            image: "assets/images/join_instructions/menu.png"),
      ],
    );
  }


}
