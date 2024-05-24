import 'package:flutter/material.dart'; // Importa o pacote Flutter Material
import 'package:sa_2_guibrum/Repository/UserRepository.dart'; // Importa o repositório de usuários
import '../Model/User.dart'; // Importa a classe User

class RegisterView extends StatelessWidget {
  final UserRepository userRepository = UserRepository(); // Instância do repositório de usuários
  final TextEditingController _usernameController = TextEditingController(); // Controlador para o campo de usuário
  final TextEditingController _passwordController = TextEditingController(); // Controlador para o campo de senha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'), // Título da barra de aplicativo
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'), // Campo de entrada para o nome de usuário
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'), // Campo de entrada para a senha
                obscureText: true, // Oculta o texto da senha
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final username = _usernameController.text.trim(); // Obtém o nome de usuário digitado
                  final password = _passwordController.text.trim(); // Obtém a senha digitada
                  final user = User(username: username, password: password); // Cria um novo usuário
                  if (username == '' || password == '') { // Verifica se os campos estão vazios
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Campos Vazios'), // Exibe mensagem de campos vazios
                      ),
                    );
                  } else {
                    await userRepository.addUser(user); // Adiciona o usuário ao repositório
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Cadastro realizado com sucesso!')), // Exibe mensagem de cadastro bem-sucedido
                    );
                    Navigator.pop(context); // Volta para a tela anterior
                  }
                },
                child: Text('Registrar'), // Texto do botão de registro
              ),
            ],
          ),
        ),
      ),
    );
  }
}
