// ignore_for_file: avoid_print, prefer_is_empty

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';
import 'package:modulo_logistica_sa/modelos/marketplace.dart';
import 'package:modulo_logistica_sa/modelos/pedidos.dart';

class TelaPedidos extends StatefulWidget {
  final Pedidos pedidos; // Recebendo a instância de Login
  final Marketplace marketplace;
  final String emailUsuario;
  const TelaPedidos(
      {Key? key,
      required this.pedidos,
      required this.marketplace,
      required this.emailUsuario})
      : super(key: key);

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {
  Map<String, List<Uint8List>> mapaImagensRestaurante = {};
  List<dynamic> listaIdRestaurantePedido = [];
  List<dynamic> listaEnderecoRestaurante = [];
  List<dynamic> listaEnderecoCliente = [];
  List<dynamic> listaClientes = [];
  List<dynamic> listaNomesItens = [];
  List<dynamic> listaQuantidadesItens = [];
  List<dynamic> listaCepRestaurantePedido = [];
  List<Uint8List> listaImagemRestaurantePedido = [];
  List<dynamic> listaNomeRestaurante = [];
  List<dynamic> listaIdPedido = [];

  @override
  void initState() {
    super.initState();
    authPedidos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Map<String, dynamic>?> authPedidos() async {
    Map<String, dynamic> request = {
      'login': widget.pedidos.loginPedidos,
      'senha': widget.pedidos.senhaPedidos,
    };

    final uriLogin = Uri.parse("http://localhost:3000/auth");

    try {
      Response response = await post(
        uriLogin,
        body: json.encode(request),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          // Adicione os cabeçalhos necessários aqui, como autorização, etc.
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseDataLogin = json.decode(response.body);
        widget.pedidos.tokenPedidos = responseDataLogin['token'];

        buscarApiPedidos();
      } else {
        // Tratar outros códigos de status, se necessário
        print('Erro na requisição: ${response.statusCode}');
        return null; // Ou lançar uma exceção com detalhes do erro
      }
    } catch (e) {
      // Tratar erros de conexão ou requisição
      print('Erro na requisição exception: $e');
      return null; // Ou lançar uma exceção com detalhes do erro
    }
    return null;
  }

  Future<void> buscarApiPedidos() async {
    Uri uri = Uri.parse(
        "http://localhost:3000/pedidos?status=PRONTO_PARA_COLETA&pagina=0");
    try {
      Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': 'Bearer '
              '${widget.pedidos.tokenPedidos}', // Substitua pelo seu token real
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> pedidos = responseData['listagem'];
        if (mounted) {
          setState(() {
            listaEnderecoCliente.clear();
            listaIdPedido.clear();
            listaIdRestaurantePedido.clear();
            listaEnderecoRestaurante.clear();
            listaClientes.clear();
            listaNomeRestaurante.clear();
            listaNomesItens.clear();
            listaImagemRestaurantePedido.clear();
            mapaImagensRestaurante.clear();
          });
        }

        for (var pedido in pedidos) {
          String cepRestaurante = pedido['restaurante']['cep'];
          String nomeRestaurante = pedido['restaurante']['nome'];

          String cliente = pedido['cliente']['nome'];
          String ruaCliente = pedido['endereco']['rua'];
          String bairroCliente = pedido['endereco']['bairro'];
          String cidadeCliente = pedido['endereco']['cidade'];
          String estadoCliente = pedido['endereco']['estado'];
          String idRestaurante =
              pedido['restaurante']['id_restaurante'].toString();
          String idPedido = pedido['id_pedido'].toString();

          String enderecoCompletoCliente =
              '$ruaCliente - $bairroCliente - $cidadeCliente, $estadoCliente';

          String rua = pedido['restaurante']['rua'];
          String bairro = pedido['restaurante']['bairro'];
          String cidade = pedido['restaurante']['cidade'];

          String enderecoCompletoResta =
              '$rua - $bairro - $cidade, $cepRestaurante';

          listaEnderecoCliente.add(enderecoCompletoCliente);
          listaIdPedido.add(idPedido);
          listaIdRestaurantePedido.add(idRestaurante);
          listaEnderecoRestaurante.add(enderecoCompletoResta);
          listaClientes.add(cliente);
          listaNomeRestaurante.add(nomeRestaurante);

          List<dynamic> itensPedidos = pedido['opcoes'];
          for (var item in itensPedidos) {
            String nomeItem = item['nome'];
            int quantidade = item['qtde_itens'];

            String itemCompleto = '$quantidade - $nomeItem';

            listaNomesItens.add(itemCompleto);
          }
        }
        if (mounted) {
          setState(() {
            listaEnderecoCliente;
            listaIdPedido;
            listaIdRestaurantePedido;
            listaEnderecoRestaurante;
            listaClientes;
            listaNomeRestaurante;
            listaNomesItens;

            print('Total de pedidos recebidos: ${pedidos.length}');
            print('Total de clientes: ${listaClientes.length}');
            print(
                'Total de endereços de restaurante: ${listaEnderecoRestaurante.length}');
            print('Total de nomes de itens: ${listaNomesItens.length}');
          });
        }
        await atualizarImagensMarketplace();
      } else {
        print('Erro na requisição da duda: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição exception duda: $e');
    }
  }

  Future<void> atualizarImagensMarketplace() async {
    for (var idRestaurante in listaIdRestaurantePedido) {
      await buscarImagemMarketplace(idRestaurante.toString());
    }
  }

  Future<void> buscarImagemMarketplace(String idRestaurante) async {
    Uri uri = Uri.parse(
        "https://cardapios-mktplace-api-production.up.railway.app/restaurantes/id/$idRestaurante/foto");
    try {
      Response response = await get(
        uri,
      );

      if (response.statusCode == 200) {
        Uint8List responseImage = response.bodyBytes;

        if (!mapaImagensRestaurante.containsKey(idRestaurante)) {
          mapaImagensRestaurante[idRestaurante] = [responseImage];
        } else {
          mapaImagensRestaurante[idRestaurante]!.add(responseImage);
        }

        if (mounted) {
          setState(() {
            listaImagemRestaurantePedido = mapaImagensRestaurante.values
                .expand((images) => images)
                .toList();
            print(
                'Total de imagens carregadas: ${listaImagemRestaurantePedido.length}');
          });
        }
      }
    } catch (e) {
      print('Erro na requisição exception professor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final emailUsuario = arguments as String;

    Widget criarConteudo() {
      if (listaClientes.isEmpty ||
          listaEnderecoRestaurante.isEmpty ||
          listaNomesItens.isEmpty ||
          listaEnderecoCliente.isEmpty ||
          listaNomeRestaurante.isEmpty ||
          listaIdRestaurantePedido.isEmpty ||
          listaIdPedido.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (listaImagemRestaurantePedido.length <
          listaIdRestaurantePedido.length) {
        return const Center(
          child: Text("Aguarde, carregando imagens"),
        );
      } else if (listaClientes.isEmpty) {
        return const Center(child: Text("Sem pedidos para mostrar"));
      }

      return Center(
          child: Column(children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            authPedidos();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 160, 160, 131), // Cor do texto do botão
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 15), // Espaçamento interno do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada
            ),
            elevation: 3, // Elevação do botão
          ),
          child: const Text(
            'Atualizar pedidos',
            style: TextStyle(fontSize: 18), // Estilo do texto do botão
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.84,
            child: ListView.builder(
                itemCount: listaClientes.length,
                itemBuilder: (context, index) {
                  if (index < listaClientes.length &&
                      index < listaImagemRestaurantePedido.length &&
                      index < listaEnderecoRestaurante.length &&
                      index < listaNomesItens.length &&
                      index < listaEnderecoCliente.length &&
                      index < listaNomeRestaurante.length &&
                      index < listaIdPedido.length) {
                    return ImagemTexto(
                      imagePath: listaImagemRestaurantePedido[index],
                      enderecoRestaurante:
                          listaEnderecoRestaurante[index].toString(),
                      itemPedido: listaNomesItens[index].toString(),
                      cliente: listaClientes[index].toString(),
                      enderecoCliente: listaEnderecoCliente[index].toString(),
                      nomeRestaurante: listaNomeRestaurante[index].toString(),
                      idPedido: listaIdPedido[index].toString(),
                      emailUsuario: emailUsuario,
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }))
      ]));
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
                    child: Icon(Icons.account_circle,
                        color: Colors.white, size: 40),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const ListTile(
                  title: Text(
                    'Sair',
                    style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
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
      backgroundColor: const Color.fromARGB(255, 234, 224, 204),
      body: criarConteudo(),
      appBar: AppBar(
        title: const Text('PEDIDOS',
            style: TextStyle(
                fontSize: 45,
                fontFamily: 'Archive',
                color: Color.fromARGB(255, 77, 106, 109))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ],
      ),
    );
  }
}
