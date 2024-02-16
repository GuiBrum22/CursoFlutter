import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: GuessNumberGame(),
  ));
}

class GuessNumberGame extends StatefulWidget {
  const GuessNumberGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GuessNumberGameState createState() => _GuessNumberGameState();
}

class _GuessNumberGameState extends State<GuessNumberGame> {
  final _random = Random();
  late int _targetNumber;
  late int _guess;
  String _feedback = '';

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _targetNumber = _random.nextInt(101);
      _feedback = '';
    });
  }

  void _makeGuess() {
    setState(() {
      if (_guess == null) {
        _feedback = 'Por favor, insira um número.';
        return;
      }
      if (_guess < _targetNumber) {
        _feedback = 'Tente um número maior.';
      } else if (_guess > _targetNumber) {
        _feedback = 'Tente um número menor.';
      } else {
        _feedback = 'Parabéns! Você acertou!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivinhe o Número'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_feedback',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _guess = int.tryParse(value)!;
                });
              },
              decoration: InputDecoration(
                hintText: 'Insira seu palpite',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _makeGuess,
              child: Text('Enviar Palpite'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _resetGame,
              child: Text('Reiniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }
}
