import 'package:corrida_da_fisica_web/controller/repository/GameRepository.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';

void main() {
  runApp( ChangeNotifierProvider(create: (context) => GameRepository(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Corrida da Física',
      theme: defaultTheme,
      initialRoute: '/',
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
