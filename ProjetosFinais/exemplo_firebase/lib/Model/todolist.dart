class Todolist {
  final String id;
  final String titulo;
  final String userId;
  final DateTime timestamp;

  Todolist({
    required this.id,
    required this.titulo,
    required this.userId,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory Todolist.fromJson(Map<String, dynamic> json) {
    return Todolist(
      id: json['doc'],
      titulo: json['titulo'],
      userId: json['userId'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}