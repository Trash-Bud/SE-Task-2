import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

import '../../controller/GameRepository.dart';

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
    return Scaffold(
        appBar: CustomAppBar(),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [getTeamImage(context), getTeamName(context), getButton(context)],
        ));
  }

  Widget getTeamImage(BuildContext context) {
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
        radius: 60,
        backgroundImage: _imageController == -1 ?
        ExactAssetImage("assets/images/team/pfp${Provider.of<GameRepository>(context, listen: false).player.getTeamID()}.png") : ExactAssetImage("assets/images/team/pfp$_imageController.png"),
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

  Widget getTeamName(BuildContext context) {
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
                  Text("Equipa ${Provider.of<GameRepository>(context, listen: false).player.getTeamID().toString()}",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.bold)) :
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
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("És líder da equipa!",
                  style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 35, fontWeight: FontWeight.bold)),
              const SizedBox(width: 3),
              GestureDetector(
                onTap: (){Navigator.of(context).pushNamed("/leader");},
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
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
                  onPressed: () => {Navigator.of(context).pushNamed("/insert_code")},
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
                  onPressed: () => {Navigator.of(context).pushNamed("/create_code")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Sair da equipa"),
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
      icons.add(const SizedBox(height: 3));
    }
    return icons;
  }
}
