import 'package:flutter/material.dart';
import 'package:to_do_list_flutter/TarefaView.dart';

void main() {
  runApp(TarefaApp());
}

class TarefaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TarefaView(),
    );
  }
}