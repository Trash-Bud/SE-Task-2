import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';
import 'view/pages/main_page.dart';

void main() {
  runApp(const MyApp());
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
