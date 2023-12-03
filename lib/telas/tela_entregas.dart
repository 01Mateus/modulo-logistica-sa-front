// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/modelos/logistica.dart';

// ignore: must_be_immutable
class TelaEntregas extends StatefulWidget {
  final String emailUsuario;
  final Logistica logistica;
  
  dynamic enderecoRestaurante;
  dynamic enderecoCliente;
  dynamic clientes;
  dynamic nomesItens;
  Uint8List imagemRestaurantePedido;
  dynamic nomeRestaurante;
  dynamic idPedido;
  dynamic idFrete = 0;


  TelaEntregas({super.key, 
  required this.enderecoRestaurante,
  required this.enderecoCliente,
  required this.clientes,
  required this.nomesItens,
  required this.imagemRestaurantePedido,
  required this.nomeRestaurante, 
  required this.logistica,
  required this.idPedido,
  required this.emailUsuario,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TelaEntregasState createState() => _TelaEntregasState();
}

class _TelaEntregasState extends State<TelaEntregas> {
  


      @override
  void initState() {
    super.initState();
    authLogistica();
    buscarApiFreteAceito();
    widget.emailUsuario;
  }

  Future<Map<String, dynamic>?> authLogistica(
  ) async {
    Map<String, dynamic> request = {
      'login': widget.logistica.loginLogistica,
      'senha': widget.logistica.senhaLogistica,
    };

    final uriLogin = Uri.parse("http://localhost:9089/auth");

    try {
      Response response = await post(uriLogin,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
     
        },
      );

      

      if (response.statusCode == 200) {
        Map<String, dynamic> responseDataLogin = json.decode(response.body);
        widget.logistica.tokenLogistica = responseDataLogin['token'];

      
        print( widget.logistica.tokenLogistica);
        return responseDataLogin;
      } else {
    
        print('Erro na requisição: ${response.statusCode}');
        return null; 
      }
    } catch (e) {
   
      print('Erro na requisição exception: $e');
      return null;
    }
  }

  
 Future<void> buscarApiFreteAceito() async {


    Uri uri = Uri.parse(
        "http://localhost:9089/frete/id/${widget.idFrete}/idPedido/${widget.idPedido}/emailEntregador/${widget.emailUsuario}/aceitoParaEntrega");

    try {
      Response response = await patch(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization':
              'Bearer: ' '${widget.logistica.tokenLogistica}', 
        },
      );

      if (response.statusCode == 200) {

        print(response);
        setState(() {}); 
      } else {
        print('Erro na requisição do frete: ${response.statusCode}');
      }
    } catch (e) {

      print('Erro na requisição exception frete: $e');
    }
  }

  Future<void> buscarApiFreteEntregue() async {

    Uri uri = Uri.parse(
        "http://localhost:9089/frete/id/${widget.idFrete}/idPedido/${widget.idPedido}/emailEntregador/${widget.emailUsuario}/entregue");

    try {
      Response response = await patch(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization':
              'Bearer: ' '${widget.logistica.tokenLogistica}', 
        },
      );

      if (response.statusCode == 200) {
        print(response);
        setState(() {}); 
      } else {
        print('Erro na requisição do frete: ${response.statusCode}');
      }
    } catch (e) {

      print('Erro na requisição exception frete: $e');
    }
  }




  Color botaoCor = Colors.blue; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Entregas',
          style: TextStyle(
            fontSize: 45,
            fontFamily: 'Archive',
            color: Color.fromARGB(255, 77, 106, 109),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
      ),
      body: criarConteudo(),
      backgroundColor: const Color.fromARGB(255, 234, 224, 204),
    );
  }

  criarConteudo() {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: MemoryImage(widget.imagemRestaurantePedido),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.enderecoRestaurante,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                  const Text(
                    '\nPedido:',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'LeagueSpartan'),
                  ),
                  Text(
                    widget.nomesItens,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Cliente:',
                     style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'LeagueSpartan'),
                  ),
                  Text(
                    widget.clientes,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                   Text(
                    widget.enderecoCliente,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.nomeRestaurante,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      return Botao(
                        texto: 'Finalizar entrega',
                        funcao: () {
                          setState(() {
                            botaoCor = Colors.green;
                          });
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.of(context).pop('/pedidos');
                          });
                        },
                        cor: botaoCor,
                        icone: Icons.check,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}