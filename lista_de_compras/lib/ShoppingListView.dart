import 'package:flutter/material.dart';
import 'ShoppingListController.dart';
import 'Item.dart';

class ShoppingListView extends StatelessWidget {
  final ShoppingListController controller;

  const ShoppingListView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: ListView.builder(
        itemCount: controller.shoppingList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(controller.shoppingList[index].name),
            subtitle: Text('Quantidade: ${controller.shoppingList[index].quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (controller.shoppingList[index].quantity > 1) {
                      controller.updateItemQuantity(
                          controller.shoppingList[index].name,
                          controller.shoppingList[index].quantity - 1);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    controller.updateItemQuantity(
                        controller.shoppingList[index].name,
                        controller.shoppingList[index].quantity + 1);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    controller.removeItem(controller.shoppingList[index].name);
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_itemNameController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
                  controller.addItem(_itemNameController.text, int.parse(_quantityController.text));
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
