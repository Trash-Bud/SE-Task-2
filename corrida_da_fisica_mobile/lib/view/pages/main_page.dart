import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: Column(
          children: [getLogo(context), getButton(context)],
        ));
  }

  Widget getLogo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: Image.asset("assets/images/logo.png"),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Bem vindo(a)",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/insert_code")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Tenho um código"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/create_code")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Text("Não tenho um código", style: TextStyle(color: Theme.of(context).colorScheme.secondary )),
                  )
              )
          ),
        ],

      ),
    );
  }
}
