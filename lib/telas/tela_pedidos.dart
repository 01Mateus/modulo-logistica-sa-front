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
Future<Map<String, dynamic>?> buscarApiPedidos(
  String endereco,
  String imagePath,
  String pedido,
  String cliente,
  ) async {
    Map<String, dynamic> request = {

    };

    final uri = Uri.parse("http://localhost:3000/pedidos?status=PRONTO_PARA_COLETA&retirada=DELIVERY&pagina=0");
    try {
      Response response = await post(uri,
        body: json.encode(request),
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
      return const Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2019/02/21/19/00/restaurant-4011989_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                pedido: '1 - X-Salada\n3 - Balde de frango\n1 - X-Tudo',
                cliente: '',
                frete: '',
                mostrarFrete: false,
              ),
              SizedBox(width: 50),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2016/11/18/22/21/restaurant-1837150_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                pedido: '1 - X-Salada\n3 - Balde de frango\n1 - X-Tudo',
                cliente: '',
                frete: '',
                mostrarFrete: false, 
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 400),
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2015/02/24/11/54/vienna-647328_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                pedido: '1 - X-Salada\n3 - Balde de frango\n1 - X-Tudo',
                cliente: '',
                frete: '',
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
  