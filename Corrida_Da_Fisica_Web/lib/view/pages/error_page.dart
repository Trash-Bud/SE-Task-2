

import 'package:flutter/material.dart';

import '../components/app_bar.dart';

class ErrorPage extends StatelessWidget{
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text("Erro 404: Esta página não existe", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40),),),
    );
  }
}