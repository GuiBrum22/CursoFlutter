import 'package:exemplo_firebase/services/auth_firebase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final AuthFirebase _authFirebase = AuthFirebase();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //criar tela de registro
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(hintText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira um email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(hintText: 'Senha'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira uma senha';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration:
                            const InputDecoration(hintText: 'Confirmar Senha'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Insira uma senha';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _registrarUsuario();
                        },
                        child: Text('Registrar'),
                      ),
                    ],
                  )),
            )));
  }

  Future <void> _registrarUsuario() async {
    if (_formKey.currentState!.validate() && _passwordController.text == _confirmPasswordController.text) {
      try {
        await _authFirebase.signUp(_emailController.text,
            _passwordController.text);
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      }
    }
  }
}
