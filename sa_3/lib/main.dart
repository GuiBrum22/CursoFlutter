import 'package:flutter/material.dart'; // Importa o pacote Flutter Material
import 'View/LoginView.dart'; // Importa a tela de login

void main() {
  runApp(MyApp()); // Inicia a aplicação Flutter
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro e Login', // Título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor primária como azul
        visualDensity: VisualDensity.adaptivePlatformDensity, // Define a densidade visual adaptativa
      ),
      home: LoginView(), // Define a tela inicial como LoginView
    );
  }
}
