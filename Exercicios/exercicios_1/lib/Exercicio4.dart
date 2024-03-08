import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // Número de abas
        child: Scaffold(
          appBar: AppBar(
            title: Text('Exemplo de Abas'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Início'),
                Tab(icon: Icon(Icons.person), text: 'Perfil'),
                Tab(icon: Icon(Icons.settings), text: 'Configurações'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Conteúdo da primeira aba (Início)
              Center(
                child: Text('Conteúdo da aba Início'),
              ),
              // Conteúdo da segunda aba (Perfil)
              Center(
                child: Text('Conteúdo da aba Perfil'),
              ),
              // Conteúdo da terceira aba (Configurações)
              Center(
                child: Text('Conteúdo da aba Configurações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}