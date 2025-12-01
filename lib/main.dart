import 'package:flutter/material.dart';
import 'package:teresina_turistica_app/views/login_view.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teresina Turística',
      theme: ThemeData(
        primarySwatch: Colors.green, 
      ),
      home: LoginView(), 
    );
  }
}