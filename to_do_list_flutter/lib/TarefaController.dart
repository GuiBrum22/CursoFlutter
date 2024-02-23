import 'package:to_do_list_flutter/TarefaModel.dart';


class TarefaController {
  final List<TarefaModel> _listaDeCompras = [];

  List<TarefaModel> get listaDeCompras => _listaDeCompras;

  void adicionarItem(TarefaModel item) {
    _listaDeCompras.add(item);
  }

  void removerItem(int index) {
    _listaDeCompras.removeAt(index);
  }
}
