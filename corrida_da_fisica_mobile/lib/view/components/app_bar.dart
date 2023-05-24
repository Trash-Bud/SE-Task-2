
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar{

  CustomAppBar({super.key});

  @override
  Widget? get title =>
    const Text("Corrida da Física",
    textAlign: TextAlign.center);

  // Getting rid of back button in app bar
  @override
  bool get automaticallyImplyLeading => false;
}