import 'dart:convert';

class Produto {
  final String nome;
  final double preco;
  final String categoria;

  Produto({required this.nome, required this.preco, required this.categoria});

  Map<String, dynamic> toJson() =>
      {'nome': nome, 'valor': preco, 'categoria': categoria};

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
        nome: json['nome'], preco: json['valor'], categoria: json['categoria']);
  }
}
