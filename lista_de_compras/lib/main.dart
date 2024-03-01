import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShoppingListController.dart';
import 'ShoppingListView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ShoppingListController controller = ShoppingListController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => controller,
        child: ShoppingListView(controller: controller),
      ),
    );
  }
}