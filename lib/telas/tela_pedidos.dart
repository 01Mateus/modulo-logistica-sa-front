import 'package:flutter/material.dart';

class telaPedidos extends StatefulWidget {
  const telaPedidos({super.key});

  @override
  State<telaPedidos> createState() => _telaPedidosState();
}

class _telaPedidosState extends State<telaPedidos> {
  @override
  Widget build(BuildContext context) {

    criarConteudo() {

    }
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 241, 214),
    body: criarConteudo(),
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 167, 167, 133),
    ),   
    );
  }
}