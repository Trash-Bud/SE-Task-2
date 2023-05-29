import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/repository/GameRepository.dart';
import '../components/app_bar.dart';
import '../components/page_header.dart';


class ConnectInstructionsPage extends StatelessWidget {
  const ConnectInstructionsPage({super.key});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: getPage(context),
    );
  }

  Widget getPage(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(title:"Como se entra no jogo?", path: "/connect"),
        getContent(context)
      ],
    );
  }



  Widget getContent(BuildContext context){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 40,
                child: const Flexible(
                  child: Text("Aceder ao site www.placeholder2.com a partir de um dispositivo pessoal", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/join_instructions/main_screen.png"))
            ],
          ),
        ),


        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 40,
                child: const Flexible(
                  child: Text("Precionar inserir código e inseri-lo no campo indicado", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/join_instructions/insert_code.png"))
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 40,
                child: const Flexible(
                  child: Text("Clicar em começar o jogo", style:  TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(height: 300,  child: Image.asset("assets/images/join_instructions/menu.png"))
            ],
          ),
        ),
      ],
    );
  }


}
