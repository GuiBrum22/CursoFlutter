import 'package:exemplo_firebase/controllers/todolist_controller.dart';
import 'package:exemplo_firebase/model/todolist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final _tituloController = TextEditingController();
  final _controller = TodolistController();

  Future<void> _getTodolist(String userId) async{
    try {
      _controller.getFromFirestore(userId);
    } catch (e) {
      print(e);
    } 
  }
  @override
  void initState() {
    super.initState();
    _getTodolist(widget.user.uid);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todolist'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child:Center(
            child:Column(
              children: [
                FutureBuilder(
                  future: _getTodolist(widget.user.uid), 
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }else if(_controller.list.isEmpty){
                      return const Text('Não há nenhuma tarefa cadastrada para este Usuário');
                    }else{
                      return Expanded(
                        child: ListView.builder(
                            itemCount: _controller.list.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_controller.list[index].titulo),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: (){
                                    _controller.deleteFromFirestore(_controller.list[index].id);
                                  },
                                ),
                              );
                            }),
                      );
                    }
                  })
              ],)
          )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          //caixa dialogo
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: const Text('Nova Tarefa'),
                content: TextField(
                  controller: _tituloController,
                ),
                actions: [
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Confirmar'),
                    onPressed: (){
                      _controller.addToFirestore(
                        Todolist(
                          id: "", 
                          titulo: _tituloController.text, 
                          userId: widget.user.uid, 
                          timestamp: DateTime.now())
                      );                                             
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                ],
              );
            }
          );
        })
    );
  }
}