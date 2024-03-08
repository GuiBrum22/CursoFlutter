import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exemplo de Layout'),
        ),
        body: Column( // Uma coluna para organizar os três blocos de linha
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded( // Widget Expanded para distribuir o espaço igualmente para cada linha
              child: Row( // Primeira linha
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaço uniforme entre os itens
                children: [
                  Container( // Container 1
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Center(child: Text('Item 1')), // Texto dentro do container
                  ),
                  Container( // Container 2
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Center(child: Text('Item 2')), // Texto dentro do container
                  ),
                ],
              ),
            ),
            Expanded( // Widget Expanded para distribuir o espaço igualmente para cada linha
              child: Row( // Segunda linha
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaço uniforme entre os itens
                children: [
                  Container( // Container 3
                    width: 100,
                    height: 100,
                    color: Colors.green,
                    child: Center(child: Text('Item 3')), // Texto dentro do container
                  ),
                  Container( // Container 4
                    width: 100,
                    height: 100,
                    color: Colors.yellow,
                    child: Center(child: Text('Item 4')), // Texto dentro do container
                  ),
                ],
              ),
            ),
            Expanded( // Widget Expanded para distribuir o espaço igualmente para cada linha
              child: Row( // Terceira linha
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaço uniforme entre os itens
                children: [
                  Container( // Container 5
                    width: 100,
                    height: 100,
                    color: Colors.orange,
                    child: Center(child: Text('Item 5')), // Texto dentro do container
                  ),
                  Container( // Container 6
                    width: 100,
                    height: 100,
                    color: Colors.purple,
                    child: Center(child: Text('Item 6')), // Texto dentro do container
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}