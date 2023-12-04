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
  const TelaPedidos({Key? key, required this.pedidos, required this.marketplace, required this.emailUsuario}) : super(key: key);

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {  

  late bool  _atualizacaoRealizada = false;
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

   late Timer _timer;

  @override
  void initState() {
    super.initState();
    authPedidos();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

   
  Future<Map<String, dynamic>?> authPedidos(
  ) async {
    Map<String, dynamic> request = {
      'login': widget.pedidos.loginPedidos,
      'senha': widget.pedidos.senhaPedidos,
    };

    final uriLogin = Uri.parse("http://localhost:3000/auth");

    try {
      Response response = await post(uriLogin,
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
    Future<void> atualizarImagensMarketplace() async {
    for (var idRestaurante in listaIdRestaurantePedido) {
    await buscarImagemMarketplace(idRestaurante.toString());
    }
    }

    Future<void> buscarApiPedidos() async {

    Uri uri = Uri.parse(
        "http://localhost:3000/pedidos?status=PRONTO_PARA_COLETA&pagina=0");

    try {
      Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization':
              'Bearer ' '${widget.pedidos.tokenPedidos}', // Substitua pelo seu token real
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        List<dynamic> pedidos = responseData['listagem'];

      for (var pedido in pedidos) {
        String cepRestaurante = pedido['restaurante']['cep'];
        String nomeRestaurante = pedido['restaurante']['nome'];

        String cliente = pedido['cliente']['nome'];
        String ruaCliente = pedido['endereco']['rua'];
        String bairroCliente = pedido['endereco']['bairro'];
        String cidadeCliente = pedido['endereco']['cidade'];
        String estadoCliente = pedido['endereco']['estado'];
        String idRestaurante = pedido['restaurante']['id_restaurante'].toString();
        String idPedido = pedido['id_pedido'].toString();

        String enderecoCompletoCliente = '$ruaCliente - $bairroCliente - $cidadeCliente, $estadoCliente';

        String rua = pedido['restaurante']['rua'];
        String bairro = pedido['restaurante']['bairro'];
        String cidade = pedido['restaurante']['cidade'];

        String enderecoCompletoResta = '$rua - $bairro - $cidade, $cepRestaurante';
        
        listaEnderecoCliente.add(enderecoCompletoCliente);
        listaIdPedido.add(idPedido);
        listaIdRestaurantePedido.add(idRestaurante);
        listaEnderecoRestaurante.add(enderecoCompletoResta);
        listaClientes.add(cliente);
        listaNomeRestaurante.add(nomeRestaurante);

        buscarImagemMarketplace(idRestaurante);

        List<dynamic> itensPedidos = pedido['opcoes'];
         for (var item in itensPedidos) {
          String nomeItem = item['nome'];
          int quantidade = item['qtde_itens'];

          String itemCompleto = '$quantidade - $nomeItem';

          listaNomesItens.add(itemCompleto);
     
        }
        }         
        setState(() {
        _atualizacaoRealizada = true;
        listaEnderecoCliente;
        listaIdPedido;
        listaIdRestaurantePedido;
        listaEnderecoRestaurante;
        listaClientes;
        listaNomeRestaurante;
        listaNomesItens;

        print(listaClientes);
        print(listaEnderecoCliente);
        print(listaIdPedido);
        print(listaIdRestaurantePedido);
        print(listaEnderecoRestaurante);
        print(listaClientes);
        print(listaNomeRestaurante);
        print(listaNomesItens);

        }); 
        
      } else {
        print('Erro na requisição da duda: ${response.statusCode}');
      }
    } catch (e) {

      print('Erro na requisição exception duda: $e');
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

        // Encontrando o índice correspondente na lista de idRestaurantePedido
        int index = listaIdRestaurantePedido.indexOf(idRestaurante);
      
      // Verificando se o restaurante está na lista de pedidos
        if (index != -1) {
        // Adicionando a imagem correspondente ao restaurante na lista de imagens
          listaImagemRestaurantePedido.insert(index, responseImage);
          print(listaImagemRestaurantePedido);
        }
        
        setState(() {
          listaImagemRestaurantePedido;
        }); 
      } else {
        print('Erro na requisição do professor: ${response.statusCode}');
      }
    } catch (e) {

      print('Erro na requisição exception professor: $e');
    }
  }

 @override
Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    final emailUsuario = arguments as String;

    
  criarConteudo() {
    if (
      listaClientes.isEmpty ||
      listaEnderecoRestaurante.isEmpty ||
      listaNomesItens.isEmpty ||
      listaEnderecoCliente.isEmpty ||
      listaNomeRestaurante.isEmpty ||
      listaIdRestaurantePedido.isEmpty ||
      listaIdPedido.isEmpty
    ) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (listaClientes.length < 1 ||
             listaEnderecoRestaurante.length < 1 ||
             listaNomesItens.length < 1 ||
             listaEnderecoCliente.length < 1 ||
             listaNomeRestaurante.length < 1 ||
             listaIdRestaurantePedido.length < 1 ||
             listaIdPedido.length < 1) {
    return const Center(child: Text("Sem pedidos para mostrar"),);
  } 
    else if (listaImagemRestaurantePedido.isEmpty) {
    return const Center(
    child: Text("Aguarde, carregando imagens"),
    );
    } else {
      if (_atualizacaoRealizada) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tela atualizada'),
            ),
          );
        });
      }
    }

      return Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
               listaImagemRestaurantePedido.length > 0
                      ? ImagemTexto(
                          imagePath: listaImagemRestaurantePedido[0],
                          enderecoRestaurante: listaEnderecoRestaurante[0].toString(),
                          itemPedido: listaNomesItens[0].toString(),
                          cliente: listaClientes[0].toString(),
                          enderecoCliente: listaEnderecoCliente[0].toString(),
                          nomeRestaurante: listaNomeRestaurante[0].toString(),
                          idPedido: listaIdPedido[0].toString(),
                          emailUsuario: emailUsuario,
                        )
                      : const Text("Sem pedido para mostrar"),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
               listaImagemRestaurantePedido.length > 1
                      ? ImagemTexto(
                          imagePath: listaImagemRestaurantePedido[1],
                          enderecoRestaurante: listaEnderecoRestaurante[1].toString(),
                          itemPedido: listaNomesItens[1].toString(),
                          cliente: listaClientes[1].toString(),
                          enderecoCliente: listaEnderecoCliente[1].toString(),
                          nomeRestaurante: listaNomeRestaurante[1].toString(),
                          idPedido: listaIdPedido[1].toString(),
                          emailUsuario: emailUsuario,
                        )
                      : const Text("Sem pedido para mostrar"),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              listaImagemRestaurantePedido.length > 2
                      ? ImagemTexto(
                          imagePath: listaImagemRestaurantePedido[2],
                          enderecoRestaurante: listaEnderecoRestaurante[2].toString(),
                          itemPedido: listaNomesItens[2].toString(),
                          cliente: listaClientes[2].toString(),
                          enderecoCliente: listaEnderecoCliente[2].toString(),
                          nomeRestaurante: listaNomeRestaurante[2].toString(),
                          idPedido: listaIdPedido[2].toString(),
                          emailUsuario: emailUsuario,
                        )
                      : const Text("Sem pedido para mostrar"),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              listaImagemRestaurantePedido.length > 3
                      ? ImagemTexto(
                          imagePath: listaImagemRestaurantePedido[3],
                          enderecoRestaurante: listaEnderecoRestaurante[3].toString(),
                          itemPedido: listaNomesItens[3].toString(),
                          cliente: listaClientes[3].toString(),
                          enderecoCliente: listaEnderecoCliente[3].toString(),
                          nomeRestaurante: listaNomeRestaurante[3].toString(),
                          idPedido: listaIdPedido[3].toString(),
                          emailUsuario: emailUsuario,
                        )
                      : const Text("Sem pedido para mostrar"),
            ],
          ),
        ],
        ),
        ),
        ), 
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
      Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.account_circle, size: 30),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(
                );
                
              },
            );
          }
      ),
    ],
  ),
);
  }

}