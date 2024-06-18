import 'package:exemplo_firebase_ezequielzz/Controller/todolist_controller.dart';
import 'package:exemplo_firebase_ezequielzz/Services/auth_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exemplo_firebase_ezequielzz/Model/todolist.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  const TodolistScreen({super.key, required this.user});

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TodolistController _controller = TodolistController();
  final AuthFirebase _authFirebase = AuthFirebase();

  Future<void> _getTodolist(String userId) async {
    try {
      _controller.getFromFirebase(userId);
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 50),
            Text(
              'Teste',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 166, 0),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Firebase',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 0, 0),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              // Add your search functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app,
                color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {
              _authFirebase.signOut();
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
                future: _getTodolist(widget.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (_controller.list.isEmpty) {
                    return const Text(
                        'Nenhuma tarefa encontrada...');
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: _controller.list.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_controller.list[index].titulo),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _controller
                                      .delete(_controller.list[index].id);
                                },
                              ),
                            );
                          }),
                    );
                  }
                }),
            FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _controller.add(Todolist(
                      id: "",
                      titulo: _tituloController.text,
                      userId: widget.user.uid,
                      timestamp: DateTime.now()));
                  Navigator.of(context).pop();
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
