// Definição da classe User
class User {
  // Atributos da classe
  final String username;
  final String password;

  // Construtor da classe, usando sintaxe de parâmetros nomeados e requeridos
  User({required this.username, required this.password});

  // Método para converter o objeto User em um mapa (Map) de strings dinâmicas
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Factory method para criar um objeto User a partir de um mapa
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],  // Atribuição do valor do mapa para o atributo username
      password: map['password'],  // Atribuição do valor do mapa para o atributo password
    );
  }
}
