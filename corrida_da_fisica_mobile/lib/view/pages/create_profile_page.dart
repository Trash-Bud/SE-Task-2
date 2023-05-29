import 'dart:developer';

import 'package:corrida_da_fisica_mobile/controller/GameRepository.dart';
import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../controller/GameRepository.dart';

class CreateProfilePage extends StatefulWidget {
  CreateProfilePage({super.key});

  @override
  _CreateProfilePage createState() => _CreateProfilePage();

}

class _CreateProfilePage extends State<CreateProfilePage>{

  @override
  void initState() {
    super.initState();
    setState(() {
      _imageController = 0;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  static late int _imageController;

  List<String> profilePics = [
    'assets/images/profile/pfp1.png',
    'assets/images/profile/pfp2.png',
    'assets/images/profile/pfp3.png',
    'assets/images/profile/pfp4.png',
    'assets/images/profile/pfp5.png',
    'assets/images/profile/pfp6.png',
    'assets/images/profile/pfp7.png',
    'assets/images/profile/pfp8.png',
    'assets/images/profile/pfp9.png',
    'assets/images/profile/pfp10.png',
    'assets/images/profile/pfp11.png',
    'assets/images/profile/pfp12.png',
  ];


  void updateData() {
    //var game = Provider.of<GameRepository>(context);
    var game = Provider.of<GameRepository>(context, listen: false);
    game.setPlayer(_nameController.text, (_imageController+1));
    log("name ${_nameController.text}");
    log("img $_imageController");

    Navigator.of(context).pushNamed("/color_pfp");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: Column(
          children: [getMessage(context), getImage(context), getForm(context)],
        ));
  }

  Widget getMessage(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text("Estás aqui!",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Text("Cria o teu perfil antes de te juntares a tua equipa:",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 15)),
        ]
      )
    );
  }

  Widget getImage(BuildContext context) {
    return GestureDetector(
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
                          children: getIcons()
                      )
                    ],
                  ),
                )
        );
      },
      child: CircleAvatar(
        radius : 60,
        backgroundColor: Colors.transparent,
        backgroundImage: _imageController == -1?
          ExactAssetImage(profilePics[0]) : ExactAssetImage(profilePics[_imageController]),
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
      ),
    );
  }

  Widget getForm(BuildContext context) {
    return Column(
      children: [
        Container(
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
        Container(
            margin: const EdgeInsets.all(20),
            width: 500,
            child: ElevatedButton(
                onPressed: () => {updateData()},
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: const Text("Confirmar"),
                )
            )
        ),
      ],
    );
  }

  List<Widget> getIcons(){
    double width = MediaQuery.of(context).size.width ;
    List<Widget> icons = [];
    for (int i=0; i<6; i++){
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
                  child: Image.asset("assets/images/profile/pfp${i*2+1}.png", width: width/5),
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
                  child: Image.asset("assets/images/profile/pfp${i*2+2}.png", width: width/5),
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
