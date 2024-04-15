import 'package:flutter/material.dart';
import 'package:sa_2_guibrum/Repository/UserRepository.dart';
import 'package:sa_2_guibrum/View/RegisterView.dart';
import 'package:sa_2_guibrum/view/homeView.dart';

class LoginView extends StatelessWidget {
  final UserRepository userRepository = UserRepository();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  final user = await userRepository.getUser(username, password);
                  if (username == '' || password == '') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Campos Vazios'),
                      ),
                    );
                  } else {
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeView(user: user)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Credenciais incorretas. Tente novamente.'),
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterView()),
                  );
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
