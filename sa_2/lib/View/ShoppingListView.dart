import 'package:flutter/material.dart';
import 'package:sa_2_guibrum/Utils/ShoppingListController.dart'; 
import 'package:sa_2_guibrum/Model/Item.dart'; 

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
        title: Text(
          'Lista de Compras - Total: ${controller.calculateTotalPrice(excludeBought: true).toStringAsFixed(2)} USD',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () => controller.sortList(SortOption.alphabetical),
          ),
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: () => controller.sortList(SortOption.reverseAlphabetical),
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantidade: ${item.quantity}'),
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _confirmDeleteItem(context, item);
                  },
                ),
                Checkbox(
                  value: item.bought,
                  onChanged: (bool? value) {
                    controller.markAsBought(item.name, value ?? false);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    try {
                      controller.decrementItemQuantity(item.name);
                    } catch (e) {
                      
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    try {
                      controller.incrementItemQuantity(item.name);
                    } catch (e) {
                      
                    }
                  },
                ),
              ],
            ),
            onTap: () => _editItemDialog(context, item),
            onLongPress: () => _confirmDeleteItem(context, item),
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
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _confirmDeleteItem(context, item);
              },
            ),
            TextButton(
              onPressed: () {
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
