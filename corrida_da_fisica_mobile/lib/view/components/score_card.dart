import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/GameRepository.dart';
import '../../model/Score.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard({super.key, required this.score});

  final Score score;


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [getPlace(context), getStats(context)]
    );
  }

  getPlace(BuildContext context) {
    return Row(
      children: [
        getBadge(context),
        Text(Provider.of<GameRepository>(context).getTeams().where((element) => element.id == score.teamId).first.getName(),
            style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
            )
        )
      ],
    );
  }

  getStats(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Text("${score.getMoves()} movimentos totais", 
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 15,
              fontWeight: FontWeight.bold)),
          Text("${score.getCorrects()} perguntas certas",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text("${score.getWrongs()} perguntas erradas",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ],
      )
    );
  }

  getBadge(BuildContext context){
    var asset = "";
    switch(score.getPlace()){
      case 1:
        asset = "assets/images/first_place.png";
        break;
      case 2:
        asset = "assets/images/second_place.png";
        break;
      case 3:
        asset = "assets/images/third_place.png";
        break;
      default:
        asset = "assets/images/other_place.png";
        break;
    }
    return Image.asset(asset,
    width:  MediaQuery.of(context).size.width / 5);
  }
}
