import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({Key? key}) : super(key: key);

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {
  dynamic imagePath = "";
  dynamic endereco = "";
  dynamic qntItemPedido = "";
  dynamic itemPedido = "";
  dynamic cliente = "";
  dynamic nomeRestaurante = "";

  

  @override
  Widget build(BuildContext context) {
    criarConteudo() {
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
              ImagemTexto(
                imagePath: imagePath,
                endereco: endereco,
                cliente: cliente,
                qntItemPedido: qntItemPedido,
                itemPedido: itemPedido,
                nomeRestaurante: nomeRestaurante, 
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              ImagemTexto(
                imagePath: imagePath,
                endereco: endereco,
                cliente: cliente,
                qntItemPedido: qntItemPedido,
                itemPedido: itemPedido,
                nomeRestaurante: nomeRestaurante, 
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              ImagemTexto(
                imagePath: imagePath,
                endereco: endereco,
                cliente: cliente,
                qntItemPedido: qntItemPedido,
                itemPedido: itemPedido,
                nomeRestaurante: nomeRestaurante, 
              ),
              const SizedBox(height: 30),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              ImagemTexto(
                imagePath: imagePath,
                endereco: endereco,
                cliente: cliente,
                qntItemPedido: qntItemPedido,
                itemPedido: itemPedido,
                nomeRestaurante: nomeRestaurante, 
              ),
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
    automaticallyImplyLeading: false,
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
  