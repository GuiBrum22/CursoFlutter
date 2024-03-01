class Item {
  late final String name;
  late final int quantity;
  late final double price;
  final String selectedCurrency; // Adicione este parâmetro

  Item({required this.name, required this.quantity, required this.price, required this.selectedCurrency});
}
