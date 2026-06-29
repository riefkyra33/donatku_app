import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const DonatKuApp());
}

class DonatKuApp extends StatelessWidget {
  const DonatKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DonatKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: const Color(0xFFFFF7F9),
      ),
      home: const LoginPage(),
    );
  }
}