

import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/page_header.dart';


class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: getPage(context),
    );
  }

  Widget getPage(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Header(title:"Créditos:", path: "/"),
        getContent(context)
      ],
    );
  }

  Widget getContent(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Desenvolvimento e Guião", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 40)),
          Text("Carolina Figueira", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30)),
          Text("Joana Mesquita", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30)),
          SizedBox(height: 50,),
          Text("Recursos utilizados", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 40)),
          Text("Imagens de dados em https://www.svgrepo.com/collection/casino-gambling/ com a CC0 License", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30)),
          Text("Troféu em https://www.svgrepo.com/collection/awards-flat-vectors/ Joana Mesquita com a CC Attribution License", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30)),
        ],
      ),
    );
  }


}
