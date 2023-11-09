import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/telas/tela_login.dart';
import 'package:modulo_logistica_sa/telas/tela_pedidos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', routes: {
        '/login':(context) => const telaLogin(),
        '/pedidos':(context) => const telaPedidos(),
      },
    );
  }
  
}