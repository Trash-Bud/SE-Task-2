import 'package:corrida_da_fisica_mobile/utils/themes.dart';
import 'package:corrida_da_fisica_mobile/controller/GameRepository.dart';
import 'package:corrida_da_fisica_mobile/view/pages/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'controller/ThemeChanger.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDXrXZLS_hB2oKwrAII1sxx2WiA9p1xCEU",
        authDomain: "corrida-da-fisica-mobile.firebaseapp.com",
        projectId: "corrida-da-fisica-mobile",
        storageBucket: "corrida-da-fisica-mobile.appspot.com",
        messagingSenderId: "337657520270",
        appId: "1:337657520270:web:fe73268853d559c87ba9df",
        measurementId: "G-T757JB1EEE"
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
