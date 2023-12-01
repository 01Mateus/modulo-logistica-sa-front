import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';
import 'package:modulo_logistica_sa/modelos/pedidos.dart';

// ignore: must_be_immutable
class TelaEntregas extends StatefulWidget {
  TelaEntregas({Key? key}) : super(key: key);
  @override
  State<TelaEntregas> createState() => _TelaEntregasState();
}

class _TelaEntregasState extends State<TelaEntregas> {
  Pedidos pedidos = Pedidos.iniciar();
  dynamic enderecoPedido;
  dynamic fretePedido;
  dynamic clientePedido;
  dynamic nomeItensPedido;
  dynamic quantidadeItensPedido;
  dynamic imagemRestaurantePedido;

Future<Map<String, dynamic>?> buscarApiPedidos() async {

    final uri = Uri.parse("http://localhost:3000/pedidos?status=PRONTO_PARA_COLETA&retirada=DELIVERY&pagina=0");
    try {
      Response response = await get(uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          // Adicione os cabeçalhos necessários aqui, como autorização, etc.
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else {
        // Tratar outros códigos de status, se necessário
        // ignore: avoid_print
        print('Erro na requisição: ${response.statusCode}');
        return null; // Ou lançar uma exceção com detalhes do erro
      }
    } catch (e) {
      // Tratar erros de conexão ou requisição
      // ignore: avoid_print
      print('Erro na requisição exception: $e');
      return null; // Ou lançar uma exceção com detalhes do erro
    }
  }

  void login() async {

      Map<String, dynamic>? response = await buscarApiPedidos();
      
      // ignore: avoid_print
      print(response);
      if (response != null) {
      setState(() {
        
      });
      } else {
        // Tratar erro de autenticação
        // Exemplo: exibir mensagem de erro para o usuário
      }
    }
  
  @override
  Widget build(BuildContext context) {
    criarConteudo() {
      return Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    imagemRestaurantePedido,
                endereco:
                    enderecoPedido,
                itemPedido: nomeItensPedido,
                qntItem: quantidadeItensPedido,
                cliente: clientePedido,
                mostrarFrete: false,
              ),
              const SizedBox(width: 50),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    imagemRestaurantePedido,
                endereco:
                    enderecoPedido,
                itemPedido: nomeItensPedido,
                qntItem: quantidadeItensPedido,
                cliente: clientePedido,
                mostrarFrete: false,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    imagemRestaurantePedido,
                endereco:
                    enderecoPedido,
                itemPedido: nomeItensPedido,
                qntItem: quantidadeItensPedido,
                cliente: clientePedido,
                mostrarFrete: false,
              ),
            ],
          ),
        ],
      );
    }

     return Scaffold(
  endDrawer: Drawer(
    child: Container(
      color: const Color.fromARGB(255, 167, 167, 133),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 167, 167, 133),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.account_circle, color: Colors.white, size: 40),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 77, 106, 109),
            thickness: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/entregas');
            },
            child: const ListTile(
              leading: Icon(Icons.av_timer),
              title: Text(
                'Histórico de entregas',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 121, 132, 120),
            thickness: 8,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: const ListTile(
              title: Text(
                'Sair',
                style: TextStyle(color: Colors.white),
              ),
              leading: Icon(Icons.logout),
            ),
          ),
          const Divider(
            color: Color.fromARGB(255, 121, 132, 120),
            thickness: 8,
          ),
        ],
      ),
    ),
  ),
  backgroundColor: const Color.fromARGB(255, 236, 241, 214),
  body: criarConteudo(),
  appBar: AppBar(
    title: const Text('PEDIDOS',
        style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 77, 106, 109))),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 160, 160, 131),
    actions: [
      Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }
      ),
    ],
  ),
);
  }

}
  