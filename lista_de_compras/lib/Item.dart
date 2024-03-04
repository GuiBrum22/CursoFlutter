import 'package:flutter/material.dart';

class Item {
  late String name;
  late int quantity; // Removendo inicialização tardiamente
  late double price;
  late String selectedCurrency;

  Item({
    required this.name,
    required this.quantity, // Removendo inicialização tardiamente
    required this.price,
    required this.selectedCurrency,
  });
}
