import 'package:flutter/material.dart'; // Importação do pacote Flutter para widgets de interface do usuário
import 'package:provider/provider.dart'; // Importação do pacote Provider para gerenciamento de estado
import 'ShoppingListView.dart'; // Importação do arquivo que contém a visualização da lista de compras
import 'ShoppingListController.dart'; // Importação do arquivo que contém o controlador da lista de compras

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
      // Provedor de mudança de notificação para fornecer o controlador da lista de compras para toda a árvore de widgets
      create: (context) => ShoppingListController(), // Cria uma instância do controlador da lista de compras
      child: MaterialApp(
        title: 'Lista de Compras', // Título do aplicativo
        theme: ThemeData(
          primarySwatch: Colors.blue, // Tema do aplicativo com a cor primária azul
        ),  
        home: Consumer<ShoppingListController>(
          // Consumidor para acessar o controlador da lista de compras
          builder: (context, controller, _) => ShoppingListView(
            // Constrói a visualização da lista de compras com base no controlador
            controller: controller, // Passa o controlador da lista de compras para a visualização
            selectedCurrency: selectedCurrency, // Passa a moeda selecionada para exibição de preços
          ),
        ),
      ),
    );
  }
}
