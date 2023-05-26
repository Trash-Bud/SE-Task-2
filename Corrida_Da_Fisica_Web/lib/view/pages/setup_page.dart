import 'package:corrida_da_fisica_web/view/components/app_bar.dart';
import 'package:corrida_da_fisica_web/view/components/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SetupPage extends StatefulWidget{
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPage();
}

class _SetupPage extends State<SetupPage> {

  int year = 7;
  bool theme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        const Header(title: "Criar Novo Jogo", path: "/"),
          getOptions(context)
      ],),
    );
  }

  Widget getOptions(BuildContext context){

    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        children: [
          getOption("Selecionar Ano:","year",getYearDropDownOptions(),(val) => {}),
          //getOption("Limite de jogadores por equipa:","playerNum",getThemeDropDownOptions(),(val) => {}),
          //getOption("Número de equipas:","temaNum",getThemeDropDownOptions(),(val) => {}),
          //getOption("Utilizar tema do ano?","theme",getThemeDropDownOptions(),(val) => {}),
        ],
      ),
    );

  }

  getYearDropDownOptions(){
    return [const DropdownMenuItem(
      value: 7,
      child: Text("7º Ano"),

    )];
  }

  getThemeDropDownOptions(){
    return [const DropdownMenuItem(
      value: false,
      child: Text("Não"),

    ), const DropdownMenuItem(
      value: true,
      child: Text("Sim"),

    )];
  }

  Widget getOption(String text, String key, List<DropdownMenuItem> items, Function(dynamic) onChange){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),

        DropdownButton(
          key: Key(key),
          value: items[0],
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items,
          onChanged: (val) => {},)
      ],
    );

  }

}
