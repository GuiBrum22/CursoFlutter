import 'package:app_carro/Model.dart';

class CarroController {
  late final List<Carro> _carroList = [
    Carro("Fiat Uno", "1992", ""),
    Carro("Classic", "2005", "")
  ];

  List<Carro> get listar => _carroList;

  get imagemUrl => null;

  void adicionarCarro(String modelo, int ano, String imagem) {
    Carro carro = Carro(modelo, ano, imagemUrl);
    _carroList.add(carro);
  }
}
