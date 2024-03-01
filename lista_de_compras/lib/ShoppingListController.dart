import 'package:flutter/material.dart';
import 'Item.dart';

enum SortOption { alphabetical, priceLowToHigh, priceHighToLow }

class ShoppingListController extends ChangeNotifier {
  List<Item> _shoppingList = [];

  List<Item> get shoppingList => _shoppingList;

  void addItem(String itemName, int quantity, double price) {
    bool itemExists = _shoppingList.any((item) => item.name == itemName);
    if (!itemExists) {
      _shoppingList.add(Item(name: itemName, quantity: quantity, price: price));
    } else {
      updateItemQuantity(itemName, _shoppingList.firstWhere((item) => item.name == itemName).quantity + quantity);
    }
    notifyListeners();
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
    }
  }

  void sortList(SortOption option) {
    switch (option) {
      case SortOption.alphabetical:
        _shoppingList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.priceLowToHigh:
        _shoppingList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        _shoppingList.sort((a, b) => b.price.compareTo(a.price));
        break;
    }
    notifyListeners();
  }
}
