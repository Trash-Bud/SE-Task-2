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
    var teamId = Provider.of<GameRepository>(context).player.getTeamID();
    return Row(
      children: [
        getBadge(context),
        Text(Provider.of<GameRepository>(context).getTeams()[score.teamId-1].getName(),
            style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
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
      padding: const EdgeInsets.fromLTRB(0,10,0,0),
      child: Column(
        children: [
          Text("${score.getMoves()} movimentos totais", 
              style: const TextStyle(
                  color: Color.fromRGBO(237, 146, 121, 1),
                  fontSize: 15,
              fontWeight: FontWeight.bold)),
          Text("${score.getCorrects()} perguntas certas",
              style: const TextStyle(
                  color: Color.fromRGBO(237, 146, 121, 1),
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text("${score.getWrongs()} perguntas erradas",
              style: const TextStyle(
                  color: Color.fromRGBO(237, 146, 121, 1),
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
