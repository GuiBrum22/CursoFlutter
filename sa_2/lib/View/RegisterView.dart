import 'package:flutter/material.dart';
import 'package:sa_2_guibrum/Repository/UserRepository.dart';
import '../Model/User.dart';

class RegisterView extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
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
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final username = _usernameController.text.trim();
                  final password = _passwordController.text.trim();
                  final user = User(username: username, password: password);
                  if (username == '' || password == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Campos Vazios'),
                      ),
                    );
                  } else {
                    await userRepository.addUser(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Cadastro realizado com sucesso!')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
