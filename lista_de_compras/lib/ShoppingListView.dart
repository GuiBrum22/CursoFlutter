// Importações necessárias
import 'package:flutter/material.dart';
import 'ShoppingListController.dart';
import 'Item.dart';

// Widget da tela da lista de compras
class ShoppingListView extends StatelessWidget {
  final ShoppingListController controller;

  const ShoppingListView({
    Key? key,
    required this.controller,
    required String selectedCurrency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título da barra de aplicativos
        title: Text(
          'Lista de Compras - Total: ${controller.calculateTotalPrice(excludeBought: true).toStringAsFixed(2)} USD',
        ),
        // Botões de ação na barra de aplicativos
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            // Ordenar por ordem alfabética
            onPressed: () => controller.sortList(SortOption.alphabetical),
          ),
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            // Ordenar por ordem alfabética inversa
            onPressed: () =>
                controller.sortList(SortOption.reverseAlphabetical),
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            // Ordenar por preço baixo para alto
            onPressed: () => controller.sortList(SortOption.priceLowToHigh),
          ),
          IconButton(
            icon: Icon(Icons.arrow_upward),
            // Ordenar por preço alto para baixo
            onPressed: () => controller.sortList(SortOption.priceHighToLow),
          ),
        ],
      ),
      body: ListView.builder(
        // Construindo a lista de itens
        itemCount: controller.shoppingList.length,
        itemBuilder: (context, index) {
          final item = controller.shoppingList[index];
          return ListTile(
            // Nome do item
            title: Text(item.name),
            // Informações adicionais do item
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quantidade do item
                Text('Quantidade: ${item.quantity}'),
                // Preço do item em diferentes moedas
                Row(
                  children: [
                    Text('Preço: '),
                    Text(
                      '${item.price.toStringAsFixed(2)} USD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '(${controller.convertPrice(item.price, 'BRL').toStringAsFixed(2)} BRL)',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ],
            ),
            // Ícones para ações relacionadas ao item
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  // Excluir item da lista
                  onPressed: () {
                    _confirmDeleteItem(context, item);
                  },
                ),
                Checkbox(
                  value: item.bought,
                  // Marcar como comprado/não comprado
                  onChanged: (bool? value) {
                    controller.markAsBought(item.name, value ?? false);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  // Decrementar quantidade do item
                  onPressed: () {
                    try {
                      controller.decrementItemQuantity(item.name);
                    } catch (e) {
                      // Lidar com erros
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  // Incrementar quantidade do item
                  onPressed: () {
                    try {
                      controller.incrementItemQuantity(item.name);
                    } catch (e) {
                      // Lidar com erros
                    }
                  },
                ),
              ],
            ),
            // Ações ao tocar no item
            onTap: () => _editItemDialog(context, item),
            // Ações ao pressionar e segurar o item
            onLongPress: () => _confirmDeleteItem(context, item),
          );
        },
      ),
      // Botão de adicionar novo item
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItemDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  // Diálogo para adicionar um novo item
  _addItemDialog(BuildContext context) {
    TextEditingController _itemNameController = TextEditingController();
    TextEditingController _quantityController = TextEditingController();
    TextEditingController _priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo de entrada para o nome do item
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(labelText: 'Nome do item'),
              ),
              // Campo de entrada para a quantidade do item
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              // Campo de entrada para o preço do item
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          // Ações do diálogo de adição
          actions: [
            TextButton(
              onPressed: () {
                // Verifica se os campos estão preenchidos e adiciona o item
                if (_itemNameController.text.isNotEmpty &&
                    _quantityController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  try {
                    double price = double.parse(_priceController.text);
                    int quantity = int.parse(_quantityController.text);
                    controller.addItem(
                      _itemNameController.text,
                      quantity,
                      price,
                      'BRL',
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    // Tratamento de erros ao adicionar o item
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao adicionar item: $e'),
                      ),
                    );
                  }
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  // Diálogo para editar um item existente
  _editItemDialog(BuildContext context, Item item) {
    TextEditingController _itemNameController =
        TextEditingController(text: item.name);
    TextEditingController _quantityController =
        TextEditingController(text: item.quantity.toString());
    TextEditingController _priceController =
        TextEditingController(text: item.price.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Editar Item"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo de entrada para o nome do item
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(labelText: 'Nome do item'),
              ),
              // Campo de entrada para a quantidade do item
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              // Campo de entrada para o preço do item
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          // Ações do diálogo de edição
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              // Excluir o item
              onPressed: () {
                _confirmDeleteItem(context, item);
              },
            ),
            TextButton(
              onPressed: () {
                // Verifica se os campos estão preenchidos e salva as alterações
                if (_itemNameController.text.isNotEmpty &&
                    _quantityController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  try {
                    double price = double.parse(_priceController.text);
                    int quantity = int.parse(_quantityController.text);
                    controller.updateItemName(
                        item.name, _itemNameController.text);
                    controller.updateItemPrice(item.name, price);
                    controller.updateItemQuantity(item.name, quantity);
                    Navigator.of(context).pop();
                  } catch (e) {
                    // Tratamento de erros ao salvar alterações do item
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Erro ao salvar alterações: $e'),
                      ),
                    );
                  }
                }
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  // Diálogo de confirmação para excluir um item
  _confirmDeleteItem(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Excluir Item"),
          content: Text("Tem certeza de que deseja excluir ${item.name}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Excluir o item
                controller.deleteItem(item.name);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item excluído com sucesso'),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}