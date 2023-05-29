import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:corrida_da_fisica_mobile/controller/GameRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';

void main() {
  runApp( ChangeNotifierProvider(create: (context) => GameRepository(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  static const BEUrl = "localhost:3000";
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
