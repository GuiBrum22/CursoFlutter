import 'package:flutter/material.dart';
import 'package:to_do_list_flutter/TarefaApp.dart';
import 'package:to_do_list_flutter/TarefaController.dart';
import 'package:to_do_list_flutter/TarefaModel.dart';

class TarefaView extends StatefulWidget {
  @override
  _TarefaViewState createState() => _TarefaViewState();
}

class _TarefaViewState extends State<TarefaView> {
  final controller = TarefaController();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Compras'),
      ),
      body: ListView.builder(
        itemCount: controller.listaDeCompras.length,
        itemBuilder: (context, index) {
          final item = controller.listaDeCompras[index];
          return ListTile(
            title: Text(item.nome),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  controller.removerItem(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Adicionar Item"),
                content: TextField(
                  controller: _controller,
                  decoration: InputDecoration(hintText: "Nome do item"),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        controller.adicionarItem(TarefaModel(_controller.text));
                        _controller.clear();
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text("Adicionar"),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Adicionar Item',
        child: Icon(Icons.add),
      ),
    );
  }
}
