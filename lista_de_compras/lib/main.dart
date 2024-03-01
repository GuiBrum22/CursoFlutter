import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShoppingListView.dart';
import 'ShoppingListController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String selectedCurrency = 'BRL'; // Alterando a moeda selecionada para Real Brasileiro (BRL)

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShoppingListController(),
      child: MaterialApp(
        title: 'Lista de Compras',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<ShoppingListController>(
          builder: (context, controller, _) => ShoppingListView(
            controller: controller,
            selectedCurrency: selectedCurrency,
          ),
        ),
      ),
    );
  }
}
