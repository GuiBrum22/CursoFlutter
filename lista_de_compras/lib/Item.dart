import 'package:flutter/material.dart';

// Definição da classe Item
class Item {
  String name; // Nome do item
  int quantity; // Quantidade do item
  double price; // Preço do item
  String selectedCurrency; // Moeda selecionada para o item
  bool bought; // Indica se o item foi comprado

  // Construtor da classe Item
  // Os parâmetros são obrigatórios (required), exceto bought, que tem um valor padrão de false
  Item({
    required this.name, // Nome do item é obrigatório
    required this.quantity, // Quantidade do item é obrigatória
    required this.price, // Preço do item é obrigatório
    required this.selectedCurrency, // Moeda selecionada é obrigatória
    this.bought = false, // Por padrão, o item não é comprado
  });
}