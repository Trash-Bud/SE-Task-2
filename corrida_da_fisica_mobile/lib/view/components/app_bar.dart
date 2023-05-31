
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';

class CustomAppBar extends AppBar{

  CustomAppBar({super.key});

  @override
  Widget? get title => Row(children: [
      Image.asset("assets/images/logo_no_name.png", width:50),
      const SizedBox(width: 25,),
    const Text("Corrida da Física",
    textAlign: TextAlign.center)
  ]);

  // Getting rid of back button in app bar
  @override
  bool get automaticallyImplyLeading => false;
}