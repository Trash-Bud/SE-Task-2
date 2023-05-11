import 'package:corrida_da_fisica_web/view/components/app_bar.dart';
import 'package:corrida_da_fisica_web/view/components/page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(children: [
        Header(title: "Criar Novo Jogo", path: "/")
      ],),
    );
  }
}
