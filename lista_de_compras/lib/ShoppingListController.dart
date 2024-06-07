import 'package:flutter/material.dart'; // Importação do pacote Flutter para widgets de interface do usuário
import 'Item.dart'; // Importação da classe Item para representar os itens da lista

// Enumeração para definir as opções de ordenação da lista de compras
enum SortOption {
  alphabetical, // Ordenação alfabética
  reverseAlphabetical, // Ordenação alfabética reversa
  alphabeticalDescending, // Ordenação alfabética descendente
  priceLowToHigh, // Ordenação por preço baixo para alto
  priceHighToLow // Ordenação por preço alto para baixo
}

// Classe responsável por controlar a lista de compras e seu estado
class ShoppingListController extends ChangeNotifier {
  List<Item> _shoppingList = []; // Lista de itens da compra
  Map<String, double> _exchangeRates = {
    // Mapa de taxas de câmbio para diferentes moedas
    'USD': 1.0, // Dólar americano (USD)
    'EUR': 0.85, // Euro (EUR)
    'GBP': 0.73, // Libra esterlina (GBP)
    'BRL': 0.2, // Real brasileiro (BRL)
    // Outras moedas e suas taxas de câmbio podem ser adicionadas aqui
  };
  bool _showBoughtItems =
      true; // Flag para controlar a exibição de itens comprados

  // Getter para obter a lista de compras
  List<Item> get shoppingList => _shoppingList;

  // Getter para verificar se os itens comprados estão sendo exibidos
  bool get showBoughtItems => _showBoughtItems;

  // Método para adicionar um novo item à lista de compras
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
    notifyListeners(); // Notifica os ouvintes sobre as mudanças na lista de compras
  }

  // Método para remover um item da lista de compras
  void removeItem(String itemName) {
    _shoppingList.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  // Método para excluir permanentemente um item da lista de compras
  void deleteItem(String itemName) {
    _shoppingList.removeWhere((item) => item.name == itemName);
    notifyListeners();
  }

  // Método para marcar um item como comprado ou não comprado
  void markAsBought(String itemName, bool bought) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].bought = bought;
      notifyListeners();
    }
  }

  // Método para atualizar a quantidade de um item na lista de compras
  void updateItemQuantity(String itemName, int newQuantity) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  // Método para ordenar a lista de compras com base na opção selecionada
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

  // Método para converter o preço de uma moeda para outra
  double convertPrice(double price, String targetCurrency) {
    if (_exchangeRates.containsKey(targetCurrency)) {
      double exchangeRate = _exchangeRates[targetCurrency]!;
      return price / exchangeRate;
    } else {
      throw Exception('Taxa de câmbio não encontrada para a moeda de destino');
    }
  }

  // Método para calcular o preço total da lista de compras
  double calculateTotalPrice({bool excludeBought = false}) {
    double totalPrice = 0.0;
    for (var item in _shoppingList) {
      if (!excludeBought || !item.bought) {
        totalPrice += item.price * item.quantity;
      }
    }
    return totalPrice;
  }

  // Método para atualizar o preço de um item na lista de compras
  void updateItemPrice(String itemName, double newPrice) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].price = newPrice;
      notifyListeners();
    }
  }

  // Método para atualizar o nome de um item na lista de compras
  void updateItemName(String oldItemName, String newItemName) {
    var index = _shoppingList.indexWhere((item) => item.name == oldItemName);
    if (index != -1) {
      _shoppingList[index].name = newItemName;
      notifyListeners();
    }
  }

  // Método para incrementar a quantidade de um item na lista de compras
  void incrementItemQuantity(String itemName) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1) {
      _shoppingList[index].quantity++;
      notifyListeners();
    }
  }

  // Método para decrementar a quantidade de um item na lista de compras
  void decrementItemQuantity(String itemName) {
    var index = _shoppingList.indexWhere((item) => item.name == itemName);
    if (index != -1 && _shoppingList[index].quantity > 1) {
      _shoppingList[index].quantity--;
      notifyListeners();
    }
  }

  // Método para obter os itens filtrados com base na opção de exibição de itens comprados
  List<Item> getFilteredItems() {
    if (_showBoughtItems) {
      return _shoppingList;
    } else {
      return _shoppingList.where((item) => !item.bought).toList();
    }
  }

  // Método para alternar a exibição de itens comprados na lista de compras
  void toggleShowBoughtItems() {
    _showBoughtItems = !_showBoughtItems;
    notifyListeners();
  }
}