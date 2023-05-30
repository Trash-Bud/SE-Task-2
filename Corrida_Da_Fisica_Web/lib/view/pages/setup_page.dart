import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:corrida_da_fisica_web/view/components/app_bar.dart';
import 'package:corrida_da_fisica_web/view/components/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/repository/GameRepository.dart';
import '../../controller/repository/ThemeChanger.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPage();
}

class _SetupPage extends State<SetupPage> {
  int year = 7;
  int teams = 2;
  int playerNum = 1;
  bool theme = false;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    context.read<GameRepository>().endGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Header(title: "Criar Novo Jogo", path: "/"),
          const SizedBox(
            height: 60,
          ),
          getOptions(context),
          const SizedBox(
            height: 60,
          ),
          getSubmitButton()
        ],
      ),
    );
  }

  Widget getOptions(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            getOption(
                "Selecionar Ano:", "year", getYearDropDownOptions(), year, (val) => {year = val}),
            const SizedBox(
              height: 20,
            ),
            getOption("Limite de jogadores por equipa:", "playerNum",
                getPlayersPerTeam(), playerNum, (val) => {playerNum = val}),
            const SizedBox(
              height: 20,
            ),
            getOption("Número de equipas:", "temaNum",
                getTeamsDropDownOptions(), teams, (val) => {teams = val}),
            const SizedBox(
              height: 20,
            ),
            getOption("Utilizar tema do ano?", "theme",
                getThemeDropDownOptions(), theme, (val) => {theme = val, changeTheme(), print("hello")}),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  getSubmitButton() {
    var game = Provider.of<GameRepository>(context);
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () => {
          if (_formKey.currentState!.validate())
            {
              game.numberOfTeams = teams,
              game.maxPlayerNumber = playerNum,
              game.applyTheme = theme,
              game.year = year,
              context.read<GameRepository>().connect(),
              Navigator.of(context).pushNamed("/connect")
            }
        },
        child: const Text("Criar"),
      ),
    );
  }

  changeTheme() {
      setState(() {
        var themeProvider = Provider.of<ThemeChanger>(context, listen: false);
        var game = Provider.of<GameRepository>(context, listen: false);
        if (theme) {
          themeProvider.setTheme(seventhGradeTheme);
          game.board.switchTheme(seventhGradeTheme);
        } else {
          themeProvider.setTheme(defaultTheme);
          game.board.switchTheme(defaultTheme);
        }
      });
  }

        getTeamsDropDownOptions() {
      return [
         DropdownMenuItem(
          value: 2,
          child: Text("2", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        ),
         DropdownMenuItem(
          value: 3,
          child: Text("3", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        ),
         DropdownMenuItem(
          value: 4,
          child: Text("4", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        )
      ];
    }

    getPlayersPerTeam() {
      List<DropdownMenuItem> l = [];

      for (var i = 1; i <= 10; i++) {
        l.add(DropdownMenuItem(
          value: i,
          child: Text("$i", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        ));
      }
      return l;
    }

    getYearDropDownOptions() {
      return [
        DropdownMenuItem(
          value: 7,
          child: Text("7º Ano", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        )
      ];
    }

    getThemeDropDownOptions() {
      return [
        DropdownMenuItem(
          value: false,
          child: Text("Não", style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
        ),
         DropdownMenuItem(
          value: true,
          child: Text("Sim", style: TextStyle(color: Theme.of(context).colorScheme.onBackground),),
        )
      ];
    }

    Widget getOption(String text, String key,
        List<DropdownMenuItem<dynamic>> items, dynamic initVal, Function(dynamic) func) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 20),
          ),
          SizedBox(
            height: 50,
            width: 95,
            child: DropdownButtonFormField(
              dropdownColor: Theme.of(context).colorScheme.background,
                key: Key(key),
                value: initVal,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items,
                onChanged: (val) => {func(val)}),
          ),
        ],
      );
    }
  }

