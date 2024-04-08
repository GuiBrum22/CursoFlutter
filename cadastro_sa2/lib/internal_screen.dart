import 'package:flutter/material.dart';

class InternalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Internal Screen')),
      body: Center(
        child: Text('Welcome to the internal screen!'),
      ),
    );
  }
}