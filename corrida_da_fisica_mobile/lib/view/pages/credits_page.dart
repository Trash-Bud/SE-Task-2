import 'package:flutter/material.dart';

import '../components/app_bar.dart';

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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getContent(context),
        getBackButton(context)
      ],
    );
  }

  Widget getContent(BuildContext context){
    return Container(

      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Desenvolvimento e Guião", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 40, ),textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          Text("Carolina Figueira", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30),textAlign: TextAlign.center),
          Text("Joana Mesquita", style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30),textAlign: TextAlign.center),
        ],
      ),
    );
  }

  getBackButton(BuildContext context){

    return Container(
        height: 70,
        width: 200,
        child: ElevatedButton(onPressed: () => Navigator.of(context).pushNamed("/main_menu"), child: Text("Voltar", style: TextStyle(fontSize: 30),)));

  }


}