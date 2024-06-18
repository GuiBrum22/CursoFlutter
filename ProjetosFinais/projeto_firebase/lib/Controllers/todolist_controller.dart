import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todolist.dart';

class TodolistController { 
  //
  List<Todolist> _list =[];
  List<Todolist> get list => _list;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add to firestore
  Future<void> addToFirestore(Todolist todolist) async {
    await _firestore.collection('todolist').add(todolist.toMap());
  }

  //delete from firestore
  Future<void> deleteFromFirestore(String id) async {
    await _firestore.collection('todolist').doc(id).delete();
  }

  //get from firestore
  Future<void> getFromFirestore(String userId) async {
    QuerySnapshot querySnapshot = await _firestore.collection('todolist')
    .where('userid', isEqualTo: userId).get();
    List<dynamic> result = querySnapshot.docs;
    _list = result.map((doc)=>Todolist.fromMap(doc.data)).toList();
  }

}