import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';

class TelaEntregas extends StatefulWidget {
  dynamic imagePath;
  dynamic endereco;
  dynamic qntItemPedido;
  dynamic itemPedido;
  dynamic cliente;
  dynamic nomeRestaurante;

  TelaEntregas({
    required this.imagePath,
    required this.endereco,
    required this.qntItemPedido,
    required this.itemPedido,
    required this.cliente,
    required this.nomeRestaurante,
  });

  @override
  _TelaEntregasState createState() => _TelaEntregasState();
}

class _TelaEntregasState extends State<TelaEntregas> {
  Color botaoCor = Colors.blue; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Entregas',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 77, 106, 109),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 160, 160, 131),
      ),
      body: criarConteudo(),
      backgroundColor: const Color.fromARGB(255, 236, 241, 214),
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
                    backgroundImage: NetworkImage(widget.imagePath),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.endereco,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const Text(
                    '\nPedido:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.qntItemPedido,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.itemPedido,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Cliente:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.cliente,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    widget.nomeRestaurante,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      return Botao(
                        texto: 'Finalizar entrega',
                        funcao: () {
                          setState(() {
                            botaoCor = Colors.green;
                          });
                          Future.delayed(Duration(seconds: 1), () {
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