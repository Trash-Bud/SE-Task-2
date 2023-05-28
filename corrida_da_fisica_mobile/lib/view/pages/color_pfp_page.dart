import 'dart:developer';

import 'package:corrida_da_fisica_mobile/controller/GameRepository.dart';
import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


import '../../controller/GameRepository.dart';

class ColorPFPPage extends StatefulWidget {
  ColorPFPPage({super.key});

  @override
  _ColorPFPPage createState() => _ColorPFPPage();

}

class _ColorPFPPage extends State<ColorPFPPage>{

  @override
  void initState() {
    super.initState();
    setState(() {
      _colorController = 0;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  static late int _colorController;

  List<Color> colors = [
    Colors.orange,
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.pinkAccent,
    Colors.tealAccent,
    Colors.deepPurpleAccent,
    Colors.yellow
  ];

  List<String> profileSVGs = [
    'assets/svg/pfp1.svg',
    'assets/svg/pfp2.svg',
    'assets/svg/pfp3.svg',
    'assets/svg/pfp4.svg',
    'assets/svg/pfp5.svg',
    'assets/svg/pfp6.svg',
    'assets/svg/pfp7.svg',
    'assets/svg/pfp8.svg',
    'assets/svg/pfp9.svg',
    'assets/svg/pfp10.svg',
    'assets/svg/pfp11.svg',
    'assets/svg/pfp12.svg'
  ];


  void updateData() {
    //var game = Provider.of<GameRepository>(context);
    var game = Provider.of<GameRepository>(context, listen: false);
    var image = game.player.getImage();

    game.player.setColor(_colorController);
    game.player.setColoredImage(
        SvgPicture.asset(
            'assets/svg/pfp$image.svg',
            colorFilter: ColorFilter.mode(colors[_colorController], BlendMode.srcIn),
            height: MediaQuery.of(context).size.height/8
        )
    );

    Navigator.of(context).pushNamed("/choose_team");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 251, 236, 1),
        appBar: CustomAppBar(),
        body: Column(
          children: [getImage(context), getColors(context), getForm(context)],
        ));
  }


  Widget getImage(BuildContext context) {
    var image = Provider.of<GameRepository>(context, listen: false).player.getImage();
    return
      SizedBox(
        height: MediaQuery.of(context).size.height/3,
        child: SvgPicture.asset(
            'assets/svg/pfp$image.svg',
            colorFilter: ColorFilter.mode(colors[_colorController], BlendMode.srcIn),
            height: MediaQuery.of(context).size.height/3
        ),
    );
  }

  Widget getColors(BuildContext context) {
    double width = MediaQuery.of(context).size.width ;
    return
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {setState(() => _colorController = 0);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 0 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[0],
                      ),
                    )
                ),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {setState(() => _colorController = 1);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 1 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[1],
                      ),
                    )
                ),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {setState(() => _colorController = 2);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 2 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[2],
                      ),
                    )
                ),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {setState(() => _colorController = 3);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 3 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[3],
                      ),
                    )
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {setState(() => _colorController = 4);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 4 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[4],
                      ),
                    )
                ),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {setState(() => _colorController = 5);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 5 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[5],
                      ),
                    )
                ),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {setState(() => _colorController = 6);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 6 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[6],
                      ),
                    )
                ),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () {setState(() => _colorController = 7);},
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(
                            color: _colorController == 7 ?
                            Theme.of(context).primaryColor : Colors.white,
                            blurRadius: 1,
                            spreadRadius: 1)],
                      ),
                      child: CircleAvatar(
                        radius: width/12,
                        backgroundColor: colors[7],
                      ),
                    )
                ),
              ],
            ),
          ],
        );
  }

  Widget getForm(BuildContext context) {
    return Column(
      children: [
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

}
