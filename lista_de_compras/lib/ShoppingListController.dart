import 'package:flutter/material.dart';
import 'Item.dart';

class ShoppingListController extends ChangeNotifier {
  List<Item> _shoppingList = [];

  List<Item> get shoppingList => _shoppingList;

  void addItem(String itemName, int quantity) {
    bool itemExists = _shoppingList.any((item) => item.name == itemName);
    if (!itemExists) {
      _shoppingList.add(Item(name: itemName, quantity: quantity));
      notifyListeners();
    } else {
      // Handle error: item already exists
    }
  }

  void removeItem(String itemName) {
    _shoppingList.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  void updateItemQuantity(String itemName, int newQuantity) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].quantity = newQuantity;
      notifyListeners();
    } else {
      // Handle error: item not found
    }
  }
}
