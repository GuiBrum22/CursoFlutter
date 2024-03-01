import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ShoppingListController.dart';
import 'Item.dart';

class ShoppingListView extends StatelessWidget {
  final ShoppingListController controller;

  const ShoppingListView({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () => controller.sortList(SortOption.alphabetical),
          ),
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () => controller.sortList(SortOption.priceLowToHigh),
          ),
          IconButton(
            icon: Icon(Icons.arrow_upward),
            onPressed: () => controller.sortList(SortOption.priceHighToLow),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: controller.shoppingList.length,
        itemBuilder: (context, index) {
          final item = controller.shoppingList[index];
          return ListTile(
            title: Text(item.name),
            subtitle:
                Text('Quantidade: ${item.quantity} - Preço: ${item.price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (item.quantity > 1) {
                      controller.updateItemQuantity(
                          item.name, item.quantity - 1);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    controller.updateItemQuantity(item.name, item.quantity + 1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    controller.removeItem(item.name);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItemDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

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
              TextField(
                controller: _itemNameController,
                decoration: InputDecoration(labelText: 'Nome do item'),
              ),
              TextField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_itemNameController.text.isNotEmpty &&
                    _quantityController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  controller.addItem(
                      _itemNameController.text,
                      int.parse(_quantityController.text),
                      double.parse(_priceController.text));
                  Navigator.of(context).pop();
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
