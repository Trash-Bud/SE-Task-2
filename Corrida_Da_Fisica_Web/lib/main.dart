import 'package:corrida_da_fisica_web/controller/repository/GameRepository.dart';
import 'package:corrida_da_fisica_web/controller/repository/ThemeChanger.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';

void main()  => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameRepository()),
        ChangeNotifierProvider(create: (context) => ThemeChanger(defaultTheme)),
      ],
      child: const MaterialAppWithTheme()
    );
  }
}


class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'A Corrida da Física',
      theme: theme.getTheme,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}