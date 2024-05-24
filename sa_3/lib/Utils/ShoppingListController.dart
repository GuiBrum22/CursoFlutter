import 'package:flutter/material.dart';
import 'package:sa_2_guibrum/Model/Item.dart';
import 'package:sa_2_guibrum/Model/User.dart';

enum SortOption {
  alphabetical,
  reverseAlphabetical,
  alphabeticalDescending,
  priceLowToHigh,
  priceHighToLow
}

class ShoppingListController extends ChangeNotifier {
  List<Item> _shoppingList = [];
  Map<String, double> _exchangeRates = {
    'USD': 1.0,
    'BRL': 0.2,
  };
  bool _showBoughtItems = true;
  User? _user;

  ShoppingListController(this._user);

  List<Item> get shoppingList => _shoppingList;
  bool get showBoughtItems => _showBoughtItems;
  User? get user => _user;

  void addItem(
      String itemName, int quantity, double price, String selectedCurrency) {
    bool itemExists = _shoppingList.any((item) => item.name == itemName);
    if (!itemExists) {
      _shoppingList.add(Item(
          name: itemName,
          quantity: quantity,
          price: price,
          selectedCurrency: selectedCurrency));
    } else {
      updateItemQuantity(
          itemName,
          _shoppingList.firstWhere((item) => item.name == itemName).quantity +
              quantity);
    }
    notifyListeners();
  }

  void removeItem(String itemName) {
    _shoppingList.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  void deleteItem(String itemName) {
    _shoppingList.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  void markAsBought(String itemName, bool bought) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].bought = bought;
      notifyListeners();
    }
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
      case SortOption.reverseAlphabetical:
        _shoppingList.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOption.alphabeticalDescending:
        _shoppingList.sort((a, b) => b.name.compareTo(a.name));
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

  double convertPrice(double price, String targetCurrency) {
    if (_exchangeRates.containsKey(targetCurrency)) {
      double exchangeRate = _exchangeRates[targetCurrency]!;
      return price / exchangeRate;
    } else {
      throw Exception('Taxa de câmbio não encontrada para a moeda de destino');
    }
  }

  double calculateTotalPrice({bool excludeBought = false}) {
    double totalPrice = 0.0;
    for (var item in _shoppingList) {
      if (!excludeBought || !item.bought) {
        totalPrice += item.price * item.quantity;
      }
    }
    return totalPrice;
  }

  void updateItemPrice(String itemName, double newPrice) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].price = newPrice;
      notifyListeners();
    }
  }

  void updateItemName(String oldItemName, String newItemName) {
    var index = _shoppingList.indexWhere((item) => item.name == oldItemName);
    if (index != -1) {
      _shoppingList[index].name = newItemName;
      notifyListeners();
    }
  }

  void incrementItemQuantity(String itemName) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].quantity++;
      notifyListeners();
    }
  }

  void decrementItemQuantity(String itemName) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1 && _shoppingList[index].quantity > 1) {
      _shoppingList[index].quantity--;
      notifyListeners();
    }
  }

  List<Item> getFilteredItems() {
    if (_showBoughtItems) {
      return _shoppingList;
    } else {
      return _shoppingList.where((item) => !item.bought).toList();
    }
  }

  void toggleShowBoughtItems() {
    _showBoughtItems = !_showBoughtItems;
    notifyListeners();
  }
}