
import 'package:flutter/material.dart';

class Header extends AppBar{

  Header({super.key});

  @override
  Widget? get title =>  Row(children: [
    Image.asset("assets/images/logo_no_name.png", width:100),
    const SizedBox(width: 50,),
    const Text("Corrida da Física"),
  ],);

  // Getting rid of back button in app bar
  @override
  bool get automaticallyImplyLeading => false;
}