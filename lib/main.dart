import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'views/lista_locais_view.dart';
import 'views/HomeView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Teresina Turística',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),

      themeMode: ThemeMode.system,
      home: const LoginView(),
      routes: {
        '/home': (context) => const HomeView(),
        '/lista': (context) => ListaLocaisView(),
      },
    );
  }
}
