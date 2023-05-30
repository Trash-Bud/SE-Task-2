import 'dart:developer';

import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../controller/ThemeChanger.dart';
import '../../utils/themes.dart';


class InsertCodePage extends StatefulWidget{
  const InsertCodePage({super.key});

  @override
  State<InsertCodePage> createState() => _InsertCodePage();
}

class _InsertCodePage extends State<InsertCodePage> {

  final TextEditingController _formController = TextEditingController();




  @override
  Widget build(BuildContext context) {

    var game = Provider.of<GameRepository>(context);
    navigate(game);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: getButton(context));
  }

  navigate(GameRepository game){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (game.nextPage) {
        case PageToGo.mainMenu:
          changeTheme(game);
          Navigator.pop(context);
          Navigator.of(context).pushNamed("/main_menu");
          break;
        case PageToGo.warning:
          const snackBar = SnackBar(
            content: Text('Não existe um jogo com o código inserido.'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          break;
        case PageToGo.none:
          break;
        default:
          break;
      }
      });
  }

  changeTheme(game) {
    setState(() {
      var themeProvider = Provider.of<ThemeChanger>(context, listen: false);
      if (game.themeToggle) {
        themeProvider.setTheme(seventhGradeTheme);
      } else {
        themeProvider.setTheme(defaultTheme);
      }
    });
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Insere abaixo o código do jogo",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.all(20),
          width: 500,
          child: TextFormField(
              controller: _formController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45))
                ),
              )
            )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {
                    if (_formController.text != ""){
                      Provider.of<GameRepository>(context, listen: false).gameCode = _formController.text,
                      Provider.of<GameRepository>(context, listen: false).checkJoin()
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Confirmar código"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("Voltar", style: TextStyle(color: Theme.of(context).colorScheme.secondary ) ),
                  )
              )
          ),
        ],

      ),
    );
  }
}
