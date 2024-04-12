import 'package:flutter/material.dart'; // Importa o pacote Flutter Material
import 'package:sa_2_guibrum/Repository/UserRepository.dart'; // Importa o repositório de usuários
import 'package:sa_2_guibrum/View/RegisterView.dart'; // Importa a tela de registro
import 'package:sa_2_guibrum/view/homeView.dart'; // Importa a tela inicial após o login

class LoginView extends StatelessWidget {
  final UserRepository userRepository = UserRepository(); // Instância do repositório de usuários
  final TextEditingController _usernameController = TextEditingController(); // Controlador para o campo de usuário
  final TextEditingController _passwordController = TextEditingController(); // Controlador para o campo de senha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  final user = await userRepository.getUser(username, password); // Busca o usuário no repositório

                  if (username == '' || password == '') { // Verifica se os campos estão vazios
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Campos Vazios'),
                      ),
                    );
                  } else {
                    if (user != null) { // Verifica se o usuário foi encontrado
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeView(user: user)), // Navega para a tela inicial após o login
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Credenciais incorretas. Tente novamente.'), // Exibe mensagem de credenciais incorretas
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'), // Texto do botão de login
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterView()), // Navega para a tela de registro
                  );
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
