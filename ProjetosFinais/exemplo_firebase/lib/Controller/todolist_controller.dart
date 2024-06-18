import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemplo_firebase_ezequielzz/Model/todolist.dart';

class TodolistController {
  List<Todolist> _list = [];
  List<Todolist> get list => _list;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> add(Todolist todo) async {
    await _firestore.collection('todolist').add(todo.toMap());
  }

  Future<void> delete(String id) async {
    await _firestore.collection('todolist').doc(id).delete();
  }

  Future<List<Todolist>> listar(String userId) async {
    final result = await _firestore
        .collection('todolist')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    _list = result.docs.map((doc) => Todolist.fromJson(doc.data())).toList();

    return _list;
  }

  Future<void> getFromFirebase(String userId) async {
    QuerySnapshot querySnapshot = await _firestore.collection('todolist').where('userid', isEqualTo: userId).get();
    List<dynamic> result = querySnapshot.docs as List;
    _list = result.map((doc)=>Todolist.fromJson(doc.data())).toList();
  }
}