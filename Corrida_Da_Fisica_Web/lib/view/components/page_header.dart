import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String path;

  const Header({super.key, required this.title, required this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [getBackButton(context), getTitle(context)],
    );
  }

  Widget getBackButton(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: TextButton(
            onPressed: () => {
              Navigator.of(context).pushNamed(path)
            },
            child: Row(children: const [
              Icon(Icons.arrow_back),
              SizedBox(
                width: 10,
              ),
              Text(
                "Voltar para o menu",
                style: TextStyle(fontSize: 20),
              )
            ])));
  }

  Widget getTitle(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),
        ));
  }
}
