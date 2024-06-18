import 'package:exemplo_firebase_ezequielzz/Screens/home_screen.dart';
import 'package:exemplo_firebase_ezequielzz/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/cadastro_screen.dart';
import 'Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teste Firebase',
      home: HomeScreen(),
      routes: {
        '/home':(context) => HomeScreen(),
        '/login':(context) => LoginScreen(),
        '/cadastro':(context) => CadastroScreen(),
      },
    );
  }
}
