import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({superkey});

  @Override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'projeto json',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: ,
    );
  
}
}