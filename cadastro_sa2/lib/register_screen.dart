import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navegar para a lista de compras após o cadastro
            Navigator.pushNamed(context, '/shoppingList');
          },
          child: Text('Cadastro'),
        ),
      ),
    );
  }
}