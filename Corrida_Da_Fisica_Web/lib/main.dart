import 'package:corrida_da_fisica_web/controller/repository/GameRepository.dart';
import 'package:corrida_da_fisica_web/controller/repository/ThemeChanger.dart';
import 'package:corrida_da_fisica_web/utils/themes.dart';
import 'package:corrida_da_fisica_web/view/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyD6EWNErs3cGsSDrlmYrwHb_rCHQj_gG9g",
        authDomain: "corrida-da-fisica-web-3adf5.firebaseapp.com",
        projectId: "corrida-da-fisica-web-3adf5",
        storageBucket: "corrida-da-fisica-web-3adf5.appspot.com",
        messagingSenderId: "1006686809644",
        appId: "1:1006686809644:web:d5014dd9bf599153bb6b89",
        measurementId: "G-LV5K2KDCJQ"
    ),
  );
  runApp(const MyApp());
}

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
      child: MaterialAppWithTheme()
    );
  }
}


class MaterialAppWithTheme extends StatelessWidget {
  MaterialAppWithTheme({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'A Corrida da Física',
      theme: theme.getTheme,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError){
            print(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done){
            return const MainPage();
          }
          return const Center(child: CircularProgressIndicator(),);
        }),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}