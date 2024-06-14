class Todolist{
  //atributos
  final String id;
  final String titulo;
  final String userId;
  final DateTime timestamp;

  Todolist({required this.id, required this.titulo, required this.userId, required this.timestamp});

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
    };
  }
  //fromMap
  factory Todolist.fromMap(Map<String, dynamic> map, String doc) {
    return Todolist(
      id: doc,
      titulo: map['titulo'],
      userId: map['userId'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}