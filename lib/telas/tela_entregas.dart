import 'package:flutter/material.dart';
import 'package:modulo_logistica_sa/componentes/botao.dart';

class TelaEntregas extends StatefulWidget {
  dynamic imagePath;
  dynamic enderecoRestaurante;
  dynamic itens;
  dynamic cliente;
  dynamic nomeRestaurante;
  dynamic enderecoCliente;

  TelaEntregas({
    required this.imagePath,
    required this.enderecoRestaurante,
    required this.itens,
    required this.cliente,
    required this.nomeRestaurante,
    required this.enderecoCliente,
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
          'ENTREGAS',
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
                    widget.enderecoRestaurante,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const Text(
                    '\nPedido:',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'LeagueSpartan'),
                  ),
                  Text(
                    widget.itens,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Cliente:',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'LeagueSpartan'),
                  ),
                  Text(
                    widget.cliente,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                  Text(
                    widget.nomeRestaurante,
                    style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Arimo'),
                  ),
                    Text(
                      widget.enderecoCliente,
                       style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Arimo'),
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