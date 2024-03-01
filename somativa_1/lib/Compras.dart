import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importe a biblioteca provider

import 'Controller.dart';
import 'View.dart';

class ListaComprasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Definindo a tela inicial como a ListaTarefasScreen e utilizando o Provider
      home: ChangeNotifierProvider<ListaComprasModel>( // Corrija a declaração do ChangeNotifierProvider
        create: (context) => ListaComprasModel(),
        child: ListaComprasScreen(),
      ),
    );
  }
}
