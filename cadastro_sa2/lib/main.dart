import 'package:flutter/material.dart'; // Importação do pacote Flutter para widgets de interface do usuário
import 'package:provider/provider.dart'; // Importação do pacote Provider para gerenciamento de estado
import 'ShoppingListView.dart'; // Importação do arquivo que contém a visualização da lista de compras
import 'ShoppingListController.dart'; // Importação do arquivo que contém o controlador da lista de compras
import 'login_screen.dart';
import 'register_screen.dart';

void main() {
  // Função principal que inicializa o aplicativo Flutter
  runApp(MyApp(selectedCurrency: 'BRL')); // Inicia o aplicativo com a moeda selecionada como BRL (Real brasileiro)
}

class MyApp extends StatelessWidget {
  final String selectedCurrency; // Moeda selecionada para exibição de preços

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
        builder: (context, controller, _) => LoginScreen(
          // Passa o controlador da lista de compras para a tela de login
          shoppingListController: controller,
          selectedCurrency: selectedCurrency,
        ),
      ),
      routes: {
        // Define rotas para as telas de login, cadastro e lista de compras
        '/login': (context) => LoginScreen(shoppingListController: ShoppingListController(), selectedCurrency: selectedCurrency),
        '/register': (context) => RegisterScreen(),
        '/shoppingList': (context) => Consumer<ShoppingListController>(
          builder: (context, controller, _) => ShoppingListView(
            controller: controller,
            selectedCurrency: selectedCurrency,
          ),
        ),
      },
    ),
  );
}


}
