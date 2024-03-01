import 'package:flutter/material.dart';
import 'Item.dart';

enum SortOption { alphabetical, priceLowToHigh, priceHighToLow }

class ShoppingListController extends ChangeNotifier {
  List<Item> _shoppingList = [];
  Map<String, double> _exchangeRates = {
    'USD': 1.0, // Valor base em dólares
    'EUR': 0.85, // Exemplo de taxa de câmbio EUR-USD
    'GBP': 0.73, // Exemplo de taxa de câmbio GBP-USD
    'BRL': 0.2, // Exemplo de taxa de câmbio BRL-USD
    // Adicione outras moedas e suas taxas de câmbio aqui
  };

  List<Item> get shoppingList => _shoppingList;

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

  double convertPrice(double price, String targetCurrency) {
    // Verifica se a moeda de destino está na lista de taxas de câmbio
    if (_exchangeRates.containsKey(targetCurrency)) {
      double exchangeRate = _exchangeRates[targetCurrency]!;
      return price / exchangeRate;
    } else {
      throw Exception('Taxa de câmbio não encontrada para a moeda de destino');
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _shoppingList) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

    // Função para editar o preço de um item
  void updateItemPrice(String itemName, double newPrice) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].price = newPrice;
      notifyListeners();
    }
  }

  // Função para editar o nome de um item
  void updateItemName(String oldItemName, String newItemName) {
    var index = _shoppingList.indexWhere((item) => item.name == oldItemName);
    if (index != -1) {
      _shoppingList[index].name = newItemName;
      notifyListeners();
    }
  }
// Função para aumentar a quantidade de um item
  void incrementItemQuantity(String itemName) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].quantity++;
      notifyListeners();
    }
  }

  // Função para diminuir a quantidade de um item
  void decrementItemQuantity(String itemName) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1 && _shoppingList[index].quantity > 1) {
      _shoppingList[index].quantity--;
      notifyListeners();
    }
  }
}

