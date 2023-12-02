// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({Key? key}) : super(key: key);

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {

  List<dynamic> listaEnderecos = [];
  List<dynamic> listaClientes = [];
  List<dynamic> listaNomesItens = [];
  List<dynamic> listaQuantidadesItens = [];
  List<dynamic> listaCepRestaurantePedido = [];
  List<dynamic> listaImagemRestaurantePedido = [];


  @override
  void initState() {
    super.initState();
    buscarApiPedidos();
  }

  Future<void> buscarApiPedidos() async {
    Uri uri = Uri.parse(
        "http://localhost:3000/pedidos?status=PRONTO_PARA_COLETA&retirada=DELIVERY&pagina=0");

    try {
      Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJpbnRlZ3JhY2FvQHBlZGlkb3MuY29tIiwiaWF0IjoxNzAxMzg2MjkzLCJleHAiOjE3MDMxODYyOTN9.HXkN8rOqizDQpdzVyh2VcP5ZQA9JH1-ZuREJGmk2Hzo', // Substitua pelo seu token real
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> pedidos = responseData['listagem'];

      for (var pedido in pedidos) {
        String cepRestaurante = pedido['restaurante']['cep'];
        String nomeRestaurante = pedido['restaurante']['nome'];
        String cliente = pedido['cliente']['nome'];

        String rua = pedido['restaurante']['rua'];
        String bairro = pedido['restaurante']['bairro'];
        String cidade = pedido['restaurante']['cidade'];

        String endereco = '$rua - $bairro - $cidade, $cepRestaurante';

        listaImagemRestaurantePedido.add(nomeRestaurante);
        listaEnderecos.add(endereco);
        listaClientes.add(cliente);

        List<dynamic> itensPedidos = pedido['opcoes'];

        for (var item in itensPedidos) {
          String nomeItem = item['nome'];
          int quantidade = item['qtde_itens'];

          String itemCompleto = '$quantidade - $nomeItem';

          listaNomesItens.add(itemCompleto);
          // Adicione outros dados às listas, se necessário
        }
        }

        setState(() {}); // Atualiza o estado da interface após buscar os pedidos
      } else {
        // ignore: avoid_print
        print('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erro na requisição exception: $e');
    }
  }

  Widget criarConteudo() {


    if( 
      listaClientes.isEmpty ||
      listaEnderecos.isEmpty ||
      listaImagemRestaurantePedido.isEmpty ||
      listaNomesItens.isEmpty) {
        return 
        const Center(
          child: CircularProgressIndicator(),
        );
      }


    print(listaCepRestaurantePedido.toString());

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 400),
            // Aqui você usaria os valores das variáveis preenchidas
            // para exibi-los no widget ImagemTexto
          ImagemTexto(
            imagePath: 'imagemRestaurantePedido',
            endereco: listaEnderecos[0].toString(),
            itemPedido: listaNomesItens[0].toString(),
            qntItem: 0,
            cliente: listaClientes[0].toString(),
            ),
            const SizedBox(width: 50),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 400),
            ImagemTexto(
              imagePath: 'imagemRestaurantePedido',
            endereco: listaEnderecos[1].toString(),
            itemPedido: listaNomesItens[1].toString(),
            qntItem: 0,
            cliente: listaClientes[1].toString(),
             ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 400),
            // Outro exemplo de uso do widget ImagemTexto
             ImagemTexto(
              imagePath: 'imagemRestaurantePedido',
            endereco: listaEnderecos[2].toString(),
            itemPedido: listaNomesItens[2].toString(),
           qntItem: 0,
            cliente: listaClientes[2].toString(),
     
             ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Icon(Icons.account_circle,
                        color: Colors.white, size: 40),
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
            },
          ),
        ],
      ),
    );
  }
}
