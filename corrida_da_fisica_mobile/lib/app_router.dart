
import 'package:corrida_da_fisica_mobile/view/pages/create_code_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/main_menu_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/main_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/insert_code_page.dart';
import 'package:corrida_da_fisica_mobile/view/pages/rules_page.dart';
import 'package:flutter/material.dart';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){

    //final args = settings.arguments;

    RouteSettings settingsNew = RouteSettings(name: settings.name);

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => MainPage(), settings: settingsNew);
      case '/insert_code':
        return MaterialPageRoute(builder: (_) => InsertCodePage(), settings: settingsNew);
      case '/create_code':
        return MaterialPageRoute(builder: (_) => CreateCodePage(), settings: settingsNew);
      case '/main_menu':
        return MaterialPageRoute(builder: (_) => MainMenuPage(), settings: settingsNew);
      case '/rules':
        return MaterialPageRoute(builder: (_) => RulesPage(), settings: settingsNew);
      default:
        return MaterialPageRoute(builder: (_) => const MainPage(), settings: settingsNew);
    }
  }


}
