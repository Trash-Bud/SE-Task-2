import 'dart:developer';

import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

import '../../controller/GameRepository.dart';
import '../../model/Team.dart';

class TeamWaitLeaderPage extends StatefulWidget {
  const TeamWaitLeaderPage({super.key});

  @override
  _TeamWaitLeaderPage createState() => _TeamWaitLeaderPage();

}

class _TeamWaitLeaderPage extends State<TeamWaitLeaderPage>{

  @override
  void initState() {
    super.initState();
    setState(() {
      _imageController = -1;
    });
  }

  static late int _imageController;
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var game = Provider.of<GameRepository>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (game.nextPage) {
        case PageToGo.rollDice:
          Navigator.of(context).pushNamed("/roll_dice");
          break;
        case PageToGo.waitTurn:
          Navigator.of(context).pushNamed("/wait_turn");
          break;
        case PageToGo.none:
          break;
        default:
          break;
      }
    });
    var teamID = game.player.getTeamID();
    var team = game.teams.where((element) => element.id == teamID).first;
    return Scaffold(
        appBar: AppBar(
        title: Row(children: [
        Provider.of<GameRepository>(context).player.getPfp(),
          const SizedBox(width: 10,),
          const Text("Corrida da Física",
            textAlign: TextAlign.center)
          ]),
          automaticallyImplyLeading: false
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [getTeamImage(context, team), getTeamName(context, team), getButton(context)],
        ));
  }

  Widget getTeamImage(BuildContext context, Team team) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,20,0,0),
      child: GestureDetector(
      onTap: (){
        showDialog(context: context,
            builder: (BuildContext context) =>
                Dialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  elevation: 16,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Center(child: Text('Escolha um ícone:')),
                      const SizedBox(height: 20),
                      Column(
                          children: getIcons(context)
                      )
                    ],
                  ),
                )
        );
      },
      child: GFAvatar(
        radius: 40,
        backgroundImage: _imageController == -1 ?
        ExactAssetImage(team.getImage()) : ExactAssetImage("assets/images/team/pfp${_imageController+1}.png"),
        shape: GFAvatarShape.standard,
        child: Align(
          alignment: Alignment.bottomRight,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 14.0,
            child: const Icon(
              Icons.brush,
              size: 16.0,
              color: Colors.white,
            ),
          ),
          ),
      )
    )
    );
  }

  Widget getTeamName(BuildContext context, Team team) {
    return Center(
      child: GestureDetector(
          onTap: (){
            showDialog(context: context,
                builder: (BuildContext context) =>
                    Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          width: 500,
                          child: TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(45))
                                ),
                              )
                          )
                      ),
                    )
            );
          },
          child: Container(
              height: MediaQuery.of(context).size.height/5,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ _nameController.text == ""?
                  Text(team.getName(),
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)) :
                    Text(_nameController.text, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 3),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 10.0,
                    child: const Icon(
                      Icons.brush,
                      size: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("És líder da equipa!",
                  style: TextStyle(color: Theme.of(context).colorScheme.onError, fontSize: 35, fontWeight: FontWeight.bold)),
              const SizedBox(width: 3),
              GestureDetector(
                onTap: (){Navigator.of(context).pushNamed("/leader");},
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.onError,
                  radius: 10.0,
                  child: const Icon(
                    Icons.question_mark,
                    size: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Text("Aguarda pelo início do jogo...",
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20)),
          Container(
              margin: const EdgeInsets.all(10),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/question")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Bloquear equipa"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(10),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Provider.of<GameRepository>(context, listen: false).leaveTeam(), Navigator.of(context).pop()},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("Sair da equipa", style: TextStyle(color: Theme.of(context).colorScheme.secondary )),
                  )
              )
          ),
        ],

      ),
    );
  }

  List<Widget> getIcons(BuildContext context){
    double width = MediaQuery.of(context).size.width;
    List<Widget> icons = [];
    for (int i=0; i<2; i++){
      icons.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {setState(() => _imageController = i*2); Navigator.pop(context); },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                        color: _imageController == i*2 ?
                        Theme.of(context).primaryColor : Colors.white,
                        blurRadius: 0.1,
                        spreadRadius: 0.1)],
                  ),
                  child: Image.asset("assets/images/team/pfp${i*2+1}.png", width: width/5),
                )
            ),
            const SizedBox(width: 3),
            GestureDetector(
                onTap: () {setState(() => _imageController = i*2+1); Navigator.pop(context); },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                        color: _imageController == i*2+1 ?
                        Theme.of(context).primaryColor : Colors.white,
                        blurRadius: 0.1,
                        spreadRadius: 0.1)],
                  ),
                  child: Image.asset("assets/images/team/pfp${i*2+2}.png", width: width/5),
                )
            ),
          ],
        ),
      );
      icons.add(const SizedBox(height: 20));
    }
    return icons;
  }
}
