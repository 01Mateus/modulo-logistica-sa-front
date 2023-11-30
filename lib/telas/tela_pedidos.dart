import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/imagem_texto.dart';

class TelaPedidos extends StatefulWidget {
  const TelaPedidos({Key? key}) : super(key: key);

  @override
  State<TelaPedidos> createState() => _TelaPedidosState();
}

class _TelaPedidosState extends State<TelaPedidos> {
  @override
  Widget build(BuildContext context) {
    criarConteudo() {
      return const Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2019/02/21/19/00/restaurant-4011989_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                cliente: '',
                qntItemPedido: '3',
                itemPedido: 'X-Salada\n Balde de frango\n X-Tudo',
                mostrarBotaoPedido: true,
                mostrarBotaoConcluir: false,
                mostrarBotaoFechar: true,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2016/11/18/22/21/restaurant-1837150_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                qntItemPedido: '3',
                itemPedido: 'X-Salada\n Balde de frango\n X-Tudo',
                cliente: '',
                mostrarBotaoPedido: true,
                mostrarBotaoConcluir: false,
                mostrarBotaoFechar: true,  
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              ImagemTexto(
                imagePath:
                    'https://cdn.pixabay.com/photo/2015/02/24/11/54/vienna-647328_1280.jpg',
                endereco:
                    '\nRodovia SC 441, Rod. Arno Arnaldo Napoli,\n248 - Centro, Jaguaruna - SC',
                qntItemPedido: '3',
                itemPedido: 'X-Salada\n Balde de frango\n X-Tudo',
                cliente: '',
                mostrarBotaoPedido: true,
                mostrarBotaoConcluir: false,
                mostrarBotaoFechar: true,
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
          const Divider(
            color: Color.fromARGB(255, 77, 106, 109),
            thickness: 10,
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
  