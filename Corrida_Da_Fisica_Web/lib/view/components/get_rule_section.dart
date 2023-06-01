

import 'package:flutter/cupertino.dart';

class RuleSection extends StatelessWidget{

  final double width;
  final String text;
  final String image;

  const RuleSection({super.key, required this.width, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Flexible(
            child: SizedBox(
              width: width,
              child: Text(text , style:  const TextStyle(fontSize: 25), textAlign: TextAlign.center,),
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(height: 300,  child: Image.asset(image))
        ],
      ),
    );
  }


}