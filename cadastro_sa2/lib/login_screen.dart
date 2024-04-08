import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShoppingListController.dart';

class LoginScreen extends StatelessWidget {
  final String selectedCurrency;
  final ShoppingListController shoppingListController;

  const LoginScreen({
    Key? key,
    required this.selectedCurrency,
    required this.shoppingListController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulando login bem-sucedido
            shoppingListController.login();
            // Navegar para a lista de compras após o login
            Navigator.pushNamed(context, '/shoppingList');
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}