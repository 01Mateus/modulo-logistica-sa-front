import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/modelos/login.dart';
import 'package:modulo_logistica_sa/modelos/logistica.dart';
import 'package:modulo_logistica_sa/modelos/marketplace.dart';
import 'package:modulo_logistica_sa/modelos/pedidos.dart';
import 'package:modulo_logistica_sa/telas/tela_entregas.dart';
import 'package:modulo_logistica_sa/telas/tela_login.dart';
import 'package:modulo_logistica_sa/telas/tela_pedidos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', routes: {
        // ignore: prefer_const_constructors
        '/login':(context) => TelaLogin(login: Login('',''), emailUsuario: '',),
        '/pedidos':(context) => TelaPedidos(pedidos: Pedidos('integracao@pedidos.com','querocafe','token'), marketplace: Marketplace('usuario5.lojista', '123456', 'token', ''), emailUsuario: '',),
        '/entregas':(context) => TelaEntregas(enderecoRestaurante: '', enderecoCliente: '',
        clientes: '', nomesItens: '', imagemRestaurantePedido: Uint8List(0), 
        nomeRestaurante: '', logistica: Logistica('admin','fretefrete','token'), 
        idPedido: '', emailUsuario: '',)
      },
    );
  }
  
}