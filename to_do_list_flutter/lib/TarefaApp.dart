import 'package:to_do_list_flutter/TarefaController.dart';
import 'package:to_do_list_flutter/TarefaView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a ListaTarefasScreen e utilizando o Provider
      home: ChangeNotifierProvider(
        create: (context) => ListaTarefasController(),
        child: ListaTarefasScreen(),
      ),
    );
  }
}