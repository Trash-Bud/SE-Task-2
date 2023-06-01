
import 'package:corrida_da_fisica_web/view/pages/connect_page.dart';
import 'package:corrida_da_fisica_web/view/pages/credits_page.dart';
import 'package:corrida_da_fisica_web/view/pages/error_page.dart';
import 'package:corrida_da_fisica_web/view/pages/game_page.dart';
import 'package:corrida_da_fisica_web/view/pages/game_wait_page.dart';
import 'package:corrida_da_fisica_web/view/pages/main_page.dart';
import 'package:corrida_da_fisica_web/view/pages/rules_page.dart';
import 'package:corrida_da_fisica_web/view/pages/setup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppRouter{

  static Route<dynamic> generateRoute(RouteSettings settings){
    
    //final args = settings.arguments;

    RouteSettings settingsNew = RouteSettings(name: settings.name);

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const MainPage(), settings: settingsNew);
      case '/rules':
        return MaterialPageRoute(builder: (_) => const RulesPage(), settings: settingsNew);
      case '/setup':
        return MaterialPageRoute(builder: (_) => const  SetupPage(), settings: settingsNew);
      case '/connect':
        return MaterialPageRoute(builder: (_) => const  GameWaitPage(), settings: settingsNew);
      case '/game':
        return MaterialPageRoute(builder: (_) => const  GamePage(), settings: settingsNew);
      case '/how_connect':
        return MaterialPageRoute(builder: (_) => const  ConnectInstructionsPage(), settings: settingsNew);
      case '/credits':
        return MaterialPageRoute(builder: (_) => const  CreditsPage(), settings: settingsNew);
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage(), settings: settingsNew);
    }
  }


}
