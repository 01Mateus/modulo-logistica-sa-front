// ignore_for_file: avoid_print, prefer_is_empty

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';
import 'package:modulo_logistica_sa/modelos/marketplace.dart';
import 'package:modulo_logistica_sa/modelos/pedidos.dart';
import 'package:modulo_logistica_sa/modelos/urlapi.dart';

class TelaPedidos extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static GlobalKey<_TelaPedidosState> pedidosKey =
      GlobalKey<_TelaPedidosState>();

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
  List<String> listaItensPorRestaurante = [];
  List<List<String>> listaItensTotal = [];
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

    final uriLogin = Uri.parse(Urlapi().urlAutenticacaoPedidos);

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
    Uri uri = Uri.parse(Urlapi().urlPedidos);
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
            listaItensPorRestaurante.clear();
            listaItensTotal.clear();
            listaImagemRestaurantePedido.clear();
            mapaImagensRestaurante.clear();
          });
        }

        for (var pedido in pedidos) {
          listaItensPorRestaurante.clear();
          String cepRestaurante = pedido['restaurante']['cep'];
          print(cepRestaurante);
          String nomeRestaurante = pedido['restaurante']['nome'];

          String nomeCliente = pedido['cliente']['nome'];
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
          listaClientes.add(nomeCliente);
          listaNomeRestaurante.add(nomeRestaurante);

          for (var item in pedido['opcoes']) {
            String nomeItem = item[
                'nome']; // Substitua 'nome' pela chave correta que representa o nome do item no seu JSON
            String quantidade = item['qtde_itens']
                .toString(); // Substitua 'quantidade' pela chave correta que representa a quantidade

            String itemCompleto = '$quantidade - $nomeItem';

            listaItensPorRestaurante.add(itemCompleto);
          }
          listaItensTotal.add(List<String>.from(listaItensPorRestaurante));
        }

        if (mounted) {
          setState(() {
            listaEnderecoCliente;
            listaIdPedido;
            listaIdRestaurantePedido;
            listaEnderecoRestaurante;
            listaClientes;
            listaNomeRestaurante;
            listaItensTotal;

            print('Total de pedidos recebidos: ${pedidos.length}');
            print('Total de clientes: ${listaClientes.length}');
            print(
                'Total de endereços de restaurante: ${listaEnderecoRestaurante.length}');
            print(listaItensTotal);
            print('Total de nomes de itens: ${listaItensTotal.length}');
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

  String formatarLista(List<String> itens) {
    String itensFormatados = itens.join(
        '\n'); // Junta os itens em uma string separados por vírgula e espaço
    return itensFormatados;
  }

  Future<void> atualizarImagensMarketplace() async {
    for (var idRestaurante in listaIdRestaurantePedido) {
      await buscarImagemMarketplace(idRestaurante.toString());
    }
  }

  Future<void> buscarImagemMarketplace(String idRestaurante) async {
    Uri uri = Uri.parse(
        "${Urlapi().urlMarkeplace}restaurantes/id/$idRestaurante/foto");
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
          listaItensTotal.isEmpty ||
          listaItensPorRestaurante.isEmpty ||
          listaEnderecoCliente.isEmpty ||
          listaNomeRestaurante.isEmpty ||
          listaIdRestaurantePedido.isEmpty ||
          listaIdPedido.isEmpty) {
        return Center(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              buscarApiPedidos();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor:
                  const Color.fromARGB(255, 160, 160, 131), // Cor do botão
              padding: const EdgeInsets.symmetric(
                  horizontal: 30, vertical: 15), // Espaçamento interno do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Borda arredondada
              ),
              elevation: 3, // Elevação do botão
            ),
            child: const Text(
              'Atualizar pedidos',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Center(
            heightFactor: 10,
            child: CircularProgressIndicator(),
          ),
        ]));
      } else if (listaImagemRestaurantePedido.length <
          listaIdRestaurantePedido.length) {
        return const Center(
          child: Text("Aguarde, carregando imagens"),
        );
      } else if (listaClientes.isEmpty) {
        return const Center(child: Text("Sem pedidos para mostrar"));
      }
      return Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    buscarApiPedidos();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(
                        255, 160, 160, 131), // Cor do botão
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15), // Espaçamento interno do botão
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Borda arredondada
                    ),
                    elevation: 3, // Elevação do botão
                  ),
                  child: const Text(
                    'Atualizar pedidos',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                 const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    height: MediaQuery.of(context).size.height * 0.83,
                    child: ListView.builder(
                        itemCount: listaClientes.length,
                        itemBuilder: (context, index) {
                          if (index < listaClientes.length &&
                              index < listaImagemRestaurantePedido.length &&
                              index < listaEnderecoRestaurante.length &&
                              index < listaItensTotal.length &&
                              index < listaEnderecoCliente.length &&
                              index < listaNomeRestaurante.length &&
                              index < listaIdPedido.length) {
                            return ImagemTexto(
                              imagePath: listaImagemRestaurantePedido[index],
                              enderecoRestaurante:
                                  listaEnderecoRestaurante[index].toString(),
                              itemPedido: formatarLista(listaItensTotal[index]),
                              cliente: listaClientes[index].toString(),
                              enderecoCliente:
                                  listaEnderecoCliente[index].toString(),
                              nomeRestaurante:
                                  listaNomeRestaurante[index].toString(),
                              idPedido: listaIdPedido[index].toString(),
                              emailUsuario: emailUsuario,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        })),
                        const SizedBox(
                  height: 20,
                ),
              ])));
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
