import 'package:corrida_da_fisica_mobile/view/components/app_bar.dart';
import 'package:flutter/material.dart';

class InsertCodePage extends StatelessWidget {
  InsertCodePage({super.key});

  final TextEditingController _formController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: getButton(context));
  }

  Widget getButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Insere abaixo o código do jogo",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 40, fontWeight: FontWeight.bold)),
        Container(
          margin: const EdgeInsets.all(20),
          width: 500,
          child: TextFormField(
              controller: _formController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(45))
                ),
              )
            )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/main_menu")},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Confirmar código"),
                  )
              )
          ),
          Container(
              margin: const EdgeInsets.all(20),
              width: 500,
              child: OutlinedButton(
                  onPressed: () => {Navigator.of(context).pop()},
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text("Voltar"),
                  )
              )
          ),
        ],

      ),
    );
  }
}
