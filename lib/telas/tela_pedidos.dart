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
    body: criarConteudo(),
    appBar: AppBar(title: const Text('Pedidos'),),   
    );
  }
}