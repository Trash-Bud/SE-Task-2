
import 'package:corrida_da_fisica_web/view/pages/error_page.dart';
import 'package:corrida_da_fisica_web/view/pages/main_page.dart';
import 'package:corrida_da_fisica_web/view/pages/rules_page.dart';
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
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage(), settings: settingsNew);
    }
  }


}
