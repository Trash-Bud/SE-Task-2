
import 'package:corrida_da_fisica_mobile/view/pages/answer_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/choose_team_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/color_pfp_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/create_code_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/create_profile_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/game_win_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/leader_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/main_menu_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/main_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/insert_code_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/question_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/roll_dice_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/rules_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/scores_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/team_wait_leader_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/team_wait_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/tie_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/wait_answer_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/wait_turn_page.dart';
import 'package:flutter/material.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){

    //final args = settings.arguments;

    RouteSettings settingsNew = RouteSettings(name: settings.name);

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const MainPage(), settings: settingsNew);
      case '/insert_code':
        return MaterialPageRoute(builder: (_) => InsertCodePage(), settings: settingsNew);
      case '/create_code':
        return MaterialPageRoute(builder: (_) => CreateCodePage(), settings: settingsNew);
      case '/create_profile':
        return MaterialPageRoute(builder: (_) => CreateProfilePage(), settings: settingsNew);
      case '/color_pfp':
        return MaterialPageRoute(builder: (_) => ColorPFPPage(), settings: settingsNew);
      case '/choose_team':
        return MaterialPageRoute(builder: (_) => ChooseTeamPage(), settings: settingsNew);
      case '/team_wait':
        return MaterialPageRoute(builder: (_) => TeamWaitPage(), settings: settingsNew);
      case '/team_wait_leader':
        return MaterialPageRoute(builder: (_) => TeamWaitLeaderPage(), settings: settingsNew);
      case '/question':
        return MaterialPageRoute(builder: (_) => QuestionPage(), settings: settingsNew);
      case '/answer':
        return MaterialPageRoute(builder: (_) => AnswerPage(), settings: settingsNew);
      case '/wait_answer':
        return MaterialPageRoute(builder: (_) => WaitAnswerPage(), settings: settingsNew);
      case '/wait_turn':
        return MaterialPageRoute(builder: (_) => WaitTurnPage(), settings: settingsNew);
      case '/tie':
        return MaterialPageRoute(builder: (_) => TiePage(), settings: settingsNew);
      case '/roll_dice':
        return MaterialPageRoute(builder: (_) => RollDicePage(), settings: settingsNew);
      case '/game_win':
        return MaterialPageRoute(builder: (_) => GameWinPage(), settings: settingsNew);
      case '/scores':
        return MaterialPageRoute(builder: (_) => ScoresPage(), settings: settingsNew);
      case '/main_menu':
        return MaterialPageRoute(builder: (_) => MainMenuPage(), settings: settingsNew);
      case '/rules':
        return MaterialPageRoute(builder: (_) => RulesPage(), settings: settingsNew);
      case '/leader':
        return MaterialPageRoute(builder: (_) => LeaderPage(), settings: settingsNew);
      default:
        return MaterialPageRoute(builder: (_) => const MainPage(), settings: settingsNew);
    }
  }


}
