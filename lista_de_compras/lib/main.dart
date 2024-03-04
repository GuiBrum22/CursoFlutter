import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShoppingListView.dart';
import 'ShoppingListController.dart';

void main() {
  runApp(MyApp(selectedCurrency: 'BRL'));
}

class MyApp extends StatelessWidget {
  final String selectedCurrency;

  const MyApp({Key? key, required this.selectedCurrency}) : super(key: key);

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
